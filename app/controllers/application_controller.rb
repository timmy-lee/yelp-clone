class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_user
    if !current_user
      flash[:error] = 'You must be signed in to do that.'
      redirect_to businesses_path
    end
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
