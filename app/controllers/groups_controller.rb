class GroupsController < ApplicationController
before_filter :signed_in_user, only: [:index]
before_filter :admin_user,     only: [:index, :destroy, :new]

  def new
  	@group = Group.new
  end

  def create
	@group = Group.new(params[:group])
	if @group.save
	   redirect_to groups_path, notice: "Create success."
	else
        render 'new'
	end
  end

  def index
	@groups= Group.all
  end

  def destroy
    @group = Catalog.find(params[:id])
    @group.destroy
    redirect_to groups_path
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
