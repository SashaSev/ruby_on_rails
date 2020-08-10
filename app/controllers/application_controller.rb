class ApplicationController < ActionController::Base

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?

  def require_signin
    session[:intend_url] = request.url
    redirect_to new_session_url, alert: 'Please SignIn first!' unless current_user
  end
end
