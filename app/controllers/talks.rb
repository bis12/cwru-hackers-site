CwruHackersSite.controllers :talks do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

  get :index do
	  @talks = Talk.all
	  render 'talks/index'
  end

  get :talk, :map => '/talks/:id' do
	  if Talk.exists? params[:id] 
	  	@talk = Talk.find params[:id]
	  	render 'talks/talk'
	  else
		  render 'talks/notalk'
	  end
  end

end
