class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to (session[:intend_url] || user), notice: "Welcome back, #{user.name}"
      session[:intend_url] = nil
    else
      flash.now[:alert] = 'Invalid email ro password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to events_url, notice: "You're signed out"
  end
end
