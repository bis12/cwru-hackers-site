require 'tempfile'

Admin.controllers :talks do

  get :index do
    @talks = Talk.all
    render 'talks/index'
  end

  get :new do
    @talk = Talk.new
    @sponsors = Sponsor.all
    render 'talks/new'
  end

  post :create do
    sponsors = params[:talk][:sponsors]
    sponsors.each do |sponsor|
	    if sponsor[1].eql? "1" 
		spons = Sponsorship.new
		spons.talk_id = params[:id]
		spons.sponsor_id = sponsor[0]
		spons.save
	    end
    end
    params[:talk].delete 'sponsors'
    @talk = Talk.new(params[:talk])
    if @talk.save
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
	    if sponsor[1].eql? "1" #TODO: make it not duplicate on new!
		spons = Sponsorship.new
		spons.talk_id = params[:id]
		spons.sponsor_id = sponsor[0]
		spons.save
	    else
		 spons = Sponsorship.where "talk_id=#{params[:id]} and sponsor_id=#{sponsor[0]}"
		 Sponsorship.delete spons
	    end
    end
    params[:talk].delete 'sponsors'
    @talk = Talk.find(params[:id])
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
    talk = Talk.find(params[:id])
    if talk.destroy
      flash[:notice] = 'Talk was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy Talk!'
    end
    redirect url(:talks, :index)
  end
end
