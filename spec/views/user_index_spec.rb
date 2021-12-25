require 'rails_helper'

RSpec.describe 'the signin process', type: :feature do
  describe 'login page' do
    before do
      visit new_user_session_path
      User.create(name: 'Elik', email: 'elik@mail.com', password: '123456', password_confirmation: '123456',
                  confirmed_at: Date.today)
    end

    it 'shows the username and password inputs' do
      expect(page).to have_css('input[type="email"]')
      expect(page).to have_css('input[type="password"]')
    end

    it 'shows the "Submit" button' do
      expect(page).to have_button('Log in')
    end

    it 'click the submit button without filling in the email and the password shows the Error message' do
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password')
    end

    it 'filling email and password fields with incorrect data shows the Error message' do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password')
    end

    it 'filling email and password fields with correct data redirects to the root page' do
      fill_in 'Email', with: 'elik@mail.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      expect(page).to have_current_path(root_path)
    end
  end
end

RSpec.describe 'list of users in', type: :feature do
  describe 'user index page:' do
    before do
      visit new_user_session_path
      User.create(name: 'Elik', email: 'elik@mail.com', password: '123456', password_confirmation: '123456',
                  confirmed_at: Date.today)
      fill_in 'Email', with: 'elik@mail.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
    end

    it 'I can see the username of all other users' do
      expect(page).to have_selector('span.username')
      expect(page).to have_selector('span.username', between: 1..10)
    end

    it 'I can see the profile picture for each user' do
      expect(page).to have_selector('img.users-image')
      expect(page).to have_selector('img.users-image', between: 1..10)
    end

    it 'I can see the number of posts each user has written' do
      expect(page).to have_selector('span.post-count')
      expect(page).to have_selector('span.post-count', between: 0..5)
    end

    it 'When I click on a user, I am redirected to that user\'s show page' do
      click_link 'Elik'
      expect(page).to have_current_path(page.find_link('Elik')[:href])
    end
  end
end
