Admin.controllers :talks do

  get :index do
    @talks = Talk.all
    render 'talks/index'
  end

  get :new do
    @talk = Talk.new
    render 'talks/new'
  end

  post :create do
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
    render 'talks/edit'
  end

  put :update, :with => :id do
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
	  talk.video = params[:file]
	  talk.save!
	  puts talk.video.url
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
