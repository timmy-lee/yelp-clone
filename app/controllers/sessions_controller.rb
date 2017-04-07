class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to businesses_path, flash: { error: "You are already signed in"}
    else
      render 'users/sign_in'
    end
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to businesses_path, flash: {notice: 'Welcome!'}
    else
      redirect_to sign_in_path, flash: {error: 'Your username or password was incorrect'}
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to businesses_path, flash: {notice: 'You successfully logged out.'}
  end
end
