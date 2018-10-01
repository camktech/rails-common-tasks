class SessionsController < ApplicationController
  skip_before_action :check_user_session, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to tasks_path
    else
      redirect_to login_path, notice: 'Incorrect credentials.'
    end
  end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to login_path, notice: 'Successfuly logged out.'
  end
end
