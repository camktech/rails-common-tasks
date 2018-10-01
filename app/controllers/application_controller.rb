class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_user_session

private
  def check_user_session
    if !current_user
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
