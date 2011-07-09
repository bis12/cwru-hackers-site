CwruHackersSite.controllers :tag do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  get :tag, :map => '/tag/:id'  do
	  @tag = Tag.find params[:id]
	  @talks = @tag.talks
	  @people = @tag.people
	  render 'tag/tag'
  end
  
end
