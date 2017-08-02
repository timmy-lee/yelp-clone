require 'rails_helper'

feature 'user submits a review' do
  scenario 'with valid inputs' do
    business = Fabricate(:business, {monday_hr: "Closed", tuesday_hr: "Closed", wednesday_hr: "Closed", thursday_hr: "Closed", friday_hr: "Closed", saturday_hr: "Closed", sunday_hr: "Closed", monday_closing_hr: "Closed", tuesday_closing_hr: "Closed", wednesday_closing_hr: "Closed", thursday_closing_hr: "Closed", friday_closing_hr: "Closed", saturday_closing_hr: "Closed", sunday_closing_hr: "Closed"})
    lily = Fabricate(:user)
    visit sign_in_path
    fill_in 'Username', with: lily.username
    fill_in 'Password', with: lily.password
    click_button 'Log In'

    click_link(business.name)
    click_link 'Write a review'
    select('5 - Excellent')
    fill_in 'Review Details', with: 'Lorem Ipsum...'
    click_button 'Add review'
    expect(page).to have_content("Your review was successfully added")

    Percy::Capybara.snapshot(page, name: 'adding a business')
  end
end
