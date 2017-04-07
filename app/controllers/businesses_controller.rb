class BusinessesController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def index
    @businesses = Business.all
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(params.require(:business).permit(:name, :price,
                            :street, :city, :state, :zipcode, :phone,
                            :neighborbood, :monday_hr, :tuesday_hr,
                            :wednesday_hr, :thursday_hr,
                            :friday_hr, :saturday_hr,
                            :sunday_hr, :monday_closing_hr,
                            :tuesday_closing_hr, :wednesday_closing_hr,
                            :thursday_closing_hr, :friday_closing_hr,
                            :saturday_closing_hr, :sunday_closing_hr))
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

  private

  def permitted_params
  end
end
