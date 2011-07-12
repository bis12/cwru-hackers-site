CwruHackersSite.controllers :talks do

  get :index do
	  @talks = Talk.order("date DESC")
	  if @talks.length < 1 
		  @warn = "There are no talks at this time!"
	  end
	  render 'talks/index'
  end

  get :talk, :map => '/talks/:id' do
	  if Talk.exists? params[:id] 
		@talk = Talk.find params[:id]
		begin
			to_emb = BlipTV::Video.new @talk.video
			@embed = to_emb.get_attributes['embedUrl']
		rescue
			@embed = ""
			@warn = "No video with the specified id \" #{@talk.video} \" could be found at blip.tv, although the talk exists."
			puts "An error occurred: #{$!}"
		end
		if @talk.slides.url
			@slide_link = link_to 'Download PDF of slides', @talk.slides.url
		else
			@slide_link = 'No Slides Available...'
		end
		page_url = url_for "/talks/#{@talk.id}"
		@fb_link = "<iframe src='http://www.facebook.com/plugins/like.php?app_id=184252821634371&amp;href=#{page_url}&amp;send=false&amp;layout=button_count&amp;width=150&amp;show_faces=false&amp;action=like&amp;colorscheme=light&amp;font&amp;height=21' scrolling='no' frameborder='0' style='border:none; overflow:hidden; width:80px; height:21px;' allowTransparency='true'></iframe>"
	  	render 'talks/talk'
	  else
		render 'talks/notalk'
	  end
  end

end
