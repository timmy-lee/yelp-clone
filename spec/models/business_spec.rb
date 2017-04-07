require 'rails_helper'

describe Business do
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_presence_of(:street) }
  it { expect(subject).to validate_presence_of(:city) }
  it { expect(subject).to validate_presence_of(:state) }
  it { expect(subject).to validate_presence_of(:zipcode) }
  it { expect(subject).to validate_presence_of(:phone) }
  it { expect(subject).to have_many(:reviews).order('created_at DESC') }

  describe '#average_ratings' do
    it 'returns the average ratings' do
      business = Fabricate(:business)
      user = Fabricate(:user)
      review1 = Fabricate(:review, rating: 5, business_id: business.id, user_id: user.id)
      review2 = Fabricate(:review, rating: 3, business_id: business.id, user_id: user.id)
      review3 = Fabricate(:review, rating: 5, business_id: business.id, user_id: user.id)
      expect(Business.first.average_ratings).to eq(4.33)
    end

    it 'returns 0 with no reviews' do
      business = Fabricate(:business)
      user = Fabricate(:user)
      expect(Business.first.average_ratings).to eq(0)
    end
  end
end
