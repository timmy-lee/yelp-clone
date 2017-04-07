class Business < ActiveRecord::Base
  has_many :reviews, -> { order('created_at DESC')}

  validates :name, presence: true
  validates :street, presence: true
  validates :state, presence: true
  validates :phone, presence: true
  validates :city, presence: true
  validates :zipcode, presence: true

  def average_ratings
    total = 0
    if !reviews.empty?
      reviews.each do |review|
        total += review.rating
      end
      total = ((total.to_f / reviews.count)).round(2)
    end
    total
  end
end
