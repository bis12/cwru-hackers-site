require 'tempfile'

Admin.controllers :talks do

  get :index do
    @talks = Talk.all
    render 'talks/index'
  end

  get :new do
    @talk = Talk.new
    @sponsors = Sponsor.all
    @sponsorship_map = {}
    render 'talks/new'
  end

  post :create do
    sponsors = params[:talk][:sponsors]
    params[:talk].delete 'sponsors'
    puts params[:talk]
    video = params[:talk][:video]
    if not video.nil?
    	params[:talk][:video] = attach_video(video, params)
    end
    @talk = Talk.new(params[:talk])
    if @talk.save
	    sponsors.each do |sponsor|
		    if sponsor[1].eql? "1" 
			spons = Sponsorship.new
			spons.talk_id = @talk.id
			spons.sponsor_id = sponsor[0]
			spons.save
		    end
	    end
      flash[:notice] = 'Talk was successfully created.'
      redirect url(:talks, :edit, :id => @talk.id)
    else
      render 'talks/new'
    end
  end

  get :edit, :with => :id do
    @talk = Talk.find(params[:id])
    @sponsors = Sponsor.all
    sponsorships = Sponsorship.where "talk_id=#{params[:id]}"
    @sponsorship_map = {}
    sponsorships.each do |spons|
	    @sponsorship_map[spons.sponsor_id] = true
    end
    render 'talks/edit'
  end

  put :update, :with => :id do
    sponsors = params[:talk][:sponsors]
    sponsors.each do |sponsor|
	    #TODO: Fix injection possibilities, and make more activerecordy
	    if sponsor[1].eql? "1" and not Sponsorship.where("talk_id=#{params[:id]} and sponsor_id=#{sponsor[0]}").exists?
 
		spons = Sponsorship.new
		spons.talk_id = params[:id]
		spons.sponsor_id = sponsor[0]
		spons.save
	    elsif sponsor[1].eql? "0"
		 spons = Sponsorship.where "talk_id=#{params[:id]} and sponsor_id=#{sponsor[0]}"
		 Sponsorship.delete spons
	    end
    end
    params[:talk].delete 'sponsors'
    #now that the extra sponsors field is removed, this will work
    @talk = Talk.find(params[:id])
    video = params[:talk][:video]
    if not video.nil?
	    params[:talk][:video] = attach_video(video, params)
    end
    if @talk.update_attributes(params[:talk])
      flash[:notice] = 'Talk was successfully updated.'
      redirect url(:talks, :edit, :id => @talk.id)
    else
      render 'talks/edit'
    end
  end

  post :upload_images do
	  talk = Talk.find 4
	  input = request.body
	  file = upload_string_to_file input
	  talk.video = file
	  talk.save!
	  return '{success:true}'
  end

  delete :destroy, :with => :id do
    #TODO: Also destroy thumbnails and sponsorships when destroying talk
    talk = Talk.find(params[:id])
    #video = BlipTV::Video.new talk.video
    #video.delete!({
    #		    :username => APP_KEYS["bliptv"]["uname"],
    #		    :password => APP_KEYS["bliptv"]["pass"]})
    #The workaround below exists because the gem currently has the wrong url
    url, path = "blip.tv", "/?userlogin=#{APP_KEYS['bliptv']['uname']}&amp;password=#{APP_KEYS['bliptv']['pass']}&amp;cmd=delete&amp;s=file&amp;id=#{talk.video}&amp;reason=because&amp;skin=api"
    request = Net::HTTP.get(url, path) 
    hash = Hash.from_xml(request)
    if hash['response']['status'] != 'OK'
	    flash[:warning] = 'Video could not be deleted, you can manually do this <a href="http://blip.tv">here</a>'
    end
    if talk.destroy
      flash[:notice] = 'Talk was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy Talk!'
    end
    redirect url(:talks, :index)
  end
end


  def attach_video(video, params)
	    #TODO: ok, something must be fixable about this crazy situation we've got going on here...
	    #Also, move all of this to a delayed job, so that the server is not locked up!
	    vid_file = File.open(video[:tempfile])
	    saved = File.open("uploads/#{video[:filename]}", 'wb')
	    saved.write(vid_file.read)
	    saved = File.open("uploads/#{video[:filename]}", 'rb')
	    blip = BlipTV::Base.new 
	    uploaded = blip.upload_video({
		    :title => params[:talk][:title],
		    :file =>  saved,
		    :username => APP_KEYS["bliptv"]["uname"],
		    :password => APP_KEYS["bliptv"]["pass"]})
	    return uploaded.id
  end

