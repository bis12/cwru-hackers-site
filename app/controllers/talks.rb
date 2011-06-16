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
	  	render 'talks/talk'
	  else
		render 'talks/notalk'
	  end
  end

end
