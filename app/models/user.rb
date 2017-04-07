class User < ActiveRecord::Base
  has_many :reviews, -> { order('created_at DESC')}

  validates :full_name, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  has_secure_password
end
