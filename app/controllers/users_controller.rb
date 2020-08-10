class UsersController < ApplicationController

  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @registrations = @user.registrations
  end

  def new
    @user = User.new
  end

  def edit; end

  def update
    if @user.update(params_user)
      redirect_to @user, notice: 'Account successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to events_url, alert: 'Account successfully deleted'
  end

  def create
    @user = User.new(params_user)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Thanks for registered'
    else
      render :new
    end

  end

  private

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to events_url unless current_user?(@user)
  end

  def params_user
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
