class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit!)
    if @user.save
      redirect_to sign_in_path, flash: { notice: 'You have successfully registered! Please proceed to sign in'}
    else
      render :new, user: @user
    end
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end
end
