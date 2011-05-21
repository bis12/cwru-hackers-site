CwruHackersSite.controllers :talks do

  get :index do
	  @talks = Talk.all
	  render 'talks/index'
  end

  get :talk, :map => '/talks/:id' do
	  if Talk.exists? params[:id] 
		@talk = Talk.find params[:id]
		account = @talk.account
		to_emb = BlipTV::Video.new @talk.video_ext
		@embed = to_emb.get_attributes['embedUrl']
	  	render 'talks/talk'
	  else
		  render 'talks/notalk'
	  end
  end

end
