require 'rails_helper'

feature 'user submits a business', type: :feature do
  scenario 'with valid inputs' do
    lily = Fabricate(:user)
    visit sign_in_path
    fill_in 'Username', with: lily.username
    fill_in 'Password', with: lily.password
    click_button 'Log In'

    click_link 'Add a business'
    fill_in 'Business Name', with: 'Kome'
    fill_in 'Street', with: '1901 Junipero Serra Blvd'
    fill_in 'City', with: 'Daly City'
    fill_in 'State', with: 'CA'
    fill_in 'Zipcode', with: '94104'
    fill_in 'Phone Number', with: '4157748272'
    click_button 'Add Business'
    expect(page).to have_content("This business was added successfully")

    Percy::Capybara.snapshot(page, name: 'submitting a business')
  end
end
