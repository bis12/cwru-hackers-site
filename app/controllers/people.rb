CwruHackersSite.controllers :people do
  get :index do
	  @people = Person.all
	  render 'people/index'
  end

  get :person, :map => '/people/:id' do
	  if Person.exists? params[:id]
		  @person = Person.find params[:id]
		  render 'people/person'
	  else
		  render 'people/noperson'
	  end
  end
  
end
