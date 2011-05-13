CwruHackersSite.controllers :talks do

  before do
  	@viddler = Viddler::Base.new('1j4mmztdfn16ihsw934a')
  end

  get :index do
	  @talks = Talk.all
	  render 'talks/index'
  end

  get :talk, :map => '/talks/:id' do
	  if Talk.exists? params[:id] 
	  	@talk = Talk.find params[:id]
		to_emb = @viddler.find_video_by_id  @talk.video
		@embed = to_emb.embed_code
	  	render 'talks/talk'
	  else
		  render 'talks/notalk'
	  end
  end

end
