require 'rails_helper'

describe ApplicationHelper do
  describe '#time_options' do
    it 'returns an array' do
      expect(time_options).to be_instance_of(Array)
    end
  end

  describe '#days_of_week' do
    it 'returns an array of seven items' do
      expect(days_of_week).to be_instance_of(Array)
      expect(days_of_week.size).to eq(7)
    end
  end

  describe '#format_hours' do
    it 'returns a string with properly formatted time' do
      business = Fabricate(:business, monday_hr: '9:30 AM', monday_closing_hr: '8:00 PM')
      expect(format_hours(business, 'monday')).to eq('9:30 AM - 8:00 PM')
    end

    it 'returns the \'closed\' string if either opening time is closed' do
      business = Fabricate(:business, monday_hr: 'Closed', monday_closing_hr: '8:00 PM')
      expect(format_hours(business, 'monday')).to eq('Closed')
    end

    it 'returns the \'closed\' string if either closing time is closed' do
      business = Fabricate(:business, monday_hr: '9:00 AM', monday_closing_hr: 'Closed')
      expect(format_hours(business, 'monday')).to eq('Closed')
    end
  end

  describe '#pluralize_reviews' do
    it 'returns a string with the singular noun form with one review' do
      business = Fabricate(:business)
      user = Fabricate(:user)
      review1 = Fabricate(:review, business_id: business.id, user_id: user.id)
      expect(pluralize_reviews(Business.first.reviews.count)).to eq('1 review')
    end

    it 'returns a string with the plural noun form with multiple reviews' do
      business = Fabricate(:business)
      user = Fabricate(:user)
      review1 = Fabricate(:review, business_id: business.id, user_id: user.id)
      review3 = Fabricate(:review, business_id: business.id, user_id: user.id)
      review2 = Fabricate(:review, business_id: business.id, user_id: user.id)
      expect(pluralize_reviews(Business.first.reviews.count)).to eq('3 reviews')
    end
  end

  describe '#round_to_half_of_whole' do
    it 'returns a float at the closest 0.5 value' do
      expect(round_to_half_of_whole(3.7)).to eq(3.5)
      expect(round_to_half_of_whole(4.8)).to eq(5)
    end
  end

  describe '#format_num_to_class' do
    it 'returns a correctly formatted string when there is a half' do
      expect(format_num_to_class(3.5)).to eq('3half')
    end

    it 'returns a string of just the integer where it is a whole number' do
      expect(format_num_to_class(3.0)).to eq('3')
    end
  end

  describe '#format_paragraphs' do
    it 'returns an array' do
      expect(format_paragraphs('example\n content')).to be_instance_of(Array)
    end

    it 'returns a multiple elements of an array if there are newline characters' do
      text = "hello\n world\n and\n universe"
      expect(format_paragraphs(text).size).to eq(4)
    end
  end

  describe '#format_time' do
    it 'returns a string' do
      user = Fabricate(:user)
      expect(format_time(user.created_at)).to be_instance_of(String)
    end
  end
end
