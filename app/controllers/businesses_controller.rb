class BusinessesController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def index
    @businesses = Business.all
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(params.require(:business).permit!)
    if @business.save
      redirect_to(businesses_path)
    else
      render :new, flash: { success: 'This business was successfully added'}
    end
  end

  def show
    @business = Business.find(params[:id])
  end
end
