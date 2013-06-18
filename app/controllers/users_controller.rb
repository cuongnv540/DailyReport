class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy ]
  before_filter :correct_user,   only: [:edit, :update ]
  before_filter :admin_user,     only: [:destroy, :active, :define, :update] 

  def define
    @user = User.find(params[:format])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def active
    @user = User.find(params[:format])
    @user.update_attribute(:active, true)
    flash[:success] = "Account has been actived !"
  end

  def new
  	@user = User.new
  end

  def index
    @users = User.paginate(page: params[:page],per_page: 20)
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.welcome_email(@user).deliver
      UserMailer.admin_email(@user).deliver
 
      flash[:success] = "Welcome to the Sample App! please check your email and wait for active you account"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to root_path
    else
      if current_user.id == @user.id
        render 'edit' #neu la user dang sua thong tin cua chinh minh thi ve trang edit
      else
        render 'define'  #dieu huong tro ve trang sua thong tin user cua admin
      end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) || current_user.admin?
    end

   def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
