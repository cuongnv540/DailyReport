class CatalogsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :new]
  before_filter :admin_user,     only: [:index, :destroy, :update, :edit, :new]

  def new
  	@catalog = Catalog.new
  end

  def index
  	@catalogs = Catalog.all
  end

  def create
  	@catalog = Catalog.new(params[:catalog])

      if @catalog.save
		redirect_to catalogs_path
		flash[:success] = "Create success." 
      else
        render 'new'
      end
  end

  def destroy
    @catalog = Catalog.find(params[:id])
    @catalog.destroy

    redirect_to catalogs_path
  end

  def edit
    @catalog = Catalog.find(params[:id])
  end

  def update
    @catalog = Catalog.find(params[:id])

    if @catalog.update_attributes(params[:catalog])
      flash[:success] = "Catalog updated"
      redirect_to catalogs_path
    else
      render 'edit'
    end
  end

  def show
  	#@catalog = Catalog.find(params[:id])
  end

  private

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
end
