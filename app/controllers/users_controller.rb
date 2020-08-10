class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params_user)
      redirect_to @user, notice: 'Account successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
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

  def params_user
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
