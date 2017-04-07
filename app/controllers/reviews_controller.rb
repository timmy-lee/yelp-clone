class ReviewsController < ApplicationController
  def new
    if current_user
      @business = Business.find(params[:business_id])
      @review = Review.new
    else
      redirect_to sign_in_path, flash: { error: 'You must be signed in to do that' }
    end
  end

  def create
    @business = Business.find(params[:business_id])
    if current_user
      @review = Review.new(params.require(:review).permit(:rating, :content).merge!({user_id: current_user.id, business_id: @business.id}))
      if @review.save
        redirect_to business_path(params[:business_id]), flash: {notice: 'Your review was successfully added.'}
      else
        render :new, flash: { error: 'Please fix the fields below.' }
      end
    else
      redirect_to sign_in_path, flash: { error: 'You must be signed in to do that.'}
    end
  end

  def recent
    @reviews = Review.order(created_at: :desc).limit(5)
  end
end
