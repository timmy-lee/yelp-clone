require 'rails_helper'

describe User do
  it { expect(subject).to validate_presence_of(:full_name) }
  it { expect(subject).to validate_presence_of(:username) }
  it { expect(subject).to validate_uniqueness_of(:username).case_insensitive }
  it { expect(subject).to validate_presence_of(:password) }
  it { expect(subject).to have_many(:reviews).order('created_at DESC') }
end
