Admin.controllers :sponsors do

  get :index do
    @sponsors = Sponsor.all
    render 'sponsors/index'
  end

  get :new do
    @sponsor = Sponsor.new
    render 'sponsors/new'
  end

  post :create do
    @sponsor = Sponsor.new(params[:sponsor])
    if @sponsor.save
      flash[:notice] = 'Sponsor was successfully created.'
      redirect url(:sponsors, :edit, :id => @sponsor.id)
    else
      render 'sponsors/new'
    end
  end

  get :edit, :with => :id do
    @sponsor = Sponsor.find(params[:id])
    render 'sponsors/edit'
  end

  put :update, :with => :id do
    @sponsor = Sponsor.find(params[:id])
    if @sponsor.update_attributes(params[:sponsor])
      flash[:notice] = 'Sponsor was successfully updated.'
      redirect url(:sponsors, :edit, :id => @sponsor.id)
    else
      render 'sponsors/edit'
    end
  end

  delete :destroy, :with => :id do
    sponsor = Sponsor.find(params[:id])
    if sponsor.destroy
      flash[:notice] = 'Sponsor was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy Sponsor!'
    end
    redirect url(:sponsors, :index)
  end
end
