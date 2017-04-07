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
      flash[:notice] = 'This business was added successfully'
      redirect_to(businesses_path)
    else
      render :new
    end
  end

  def show
    @business = Business.find(params[:id])
  end
end
