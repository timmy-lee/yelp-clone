class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :business

  validates :content, presence: true
end
