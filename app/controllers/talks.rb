CwruHackersSite.controllers :talks do

  get :index do
  	  @viddler = Viddler::Base.new('1j4mmztdfn16ihsw934a', acc)
	  @talks = Talk.all
	  render 'talks/index'
  end

  get :talk, :map => '/talks/:id' do
	  if Talk.exists? params[:id] 
		@talk = Talk.find params[:id]
		account = @talk.account
  	  	@viddler = Viddler::Base.new('1j4mmztdfn16ihsw934a', account.vid_uname, account.vid_pass)
		to_emb = @viddler.find_video_by_id  @talk.video
		@embed = to_emb.embed_code :player_type => 'simple'
	  	render 'talks/talk'
	  else
		  render 'talks/notalk'
	  end
  end

end
