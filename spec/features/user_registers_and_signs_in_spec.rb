require 'rails_helper'

feature 'user registers' do
  scenario 'with valid inputs' do
    visit register_path
    fill_in 'Full Name', with: 'Jacky H'
    fill_in 'Desired Username', with: 'Seraphim'
    fill_in id: 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Register'
    expect(page).to have_content('You have successfully registered!')

    Percy::Capybara.snapshot(page, name: 'user registers')
  end

  scenario 'with invalid input such as already-taken username' do
    jacky = Fabricate(:user)
    visit register_path
    fill_in 'Full Name', with: 'Jacky H'
    fill_in 'Desired Username', with: jacky.username
    fill_in id: 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Register'
    expect(page).to have_content('has already been taken')

    Percy::Capybara.snapshot(page, name: 'user registers with invalid username')
  end
end

feature 'user signs in' do
  scenario 'with valid credentials' do
    lily = Fabricate(:user)
    visit sign_in_path
    fill_in 'Username', with: lily.username
    fill_in 'Password', with: lily.password
    click_button 'Log In'
    expect(page).to have_content("Hello, #{lily.full_name}")

    Percy::Capybara.snapshot(page, name: 'user signs in')
  end

  scenario 'with invalid credentials' do
    lily = Fabricate(:user)
    visit sign_in_path
    fill_in 'Username', with: lily.username
    fill_in 'Password', with: lily.password + '1'
    click_button 'Log In'
    expect(page).to have_content("Your username or password was incorrect")

    Percy::Capybara.snapshot(page, name: 'user tries to sign in')
  end
end
