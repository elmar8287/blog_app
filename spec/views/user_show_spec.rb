require 'rails_helper'
RSpec.describe 'list of users with information about the posts they wrote', type: :feature do
  describe 'user show page:' do
    before do
      visit new_user_session_path
      elik = User.create(name: 'elik', bio: 'elik is a frontend developer', email: 'elik@mail.com',
                          password: '123456', password_confirmation: '123456', confirmed_at: Date.today)
      User.create(name: 'velik', bio: 'velik is a backend developer', email: 'velik@mail.com', password: '123456',
                  password_confirmation: '123456', confirmed_at: Date.today)

      5.times do |j|
        Post.create(title: "Post ##{j + 1}", text: "#{j + 1}Lorem ipsum dolor set amet.", author: elik)
      end
      fill_in 'Email', with: 'elik@mail.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      click_link 'elik'
    end
    it 'I can see the user\'s profile picture.' do
      expect(page).to have_css('img.users-image')
    end
    it 'I can see the user\'s username.' do
      expect(page).to have_content('elik')
    end
    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content('Number of posts: 5')
    end
    it 'I can see the user\'s bio' do
      expect(page).to have_content('elik is a frontend developer')
    end
    it 'I can see the user\'s first 3 posts.' do
      expect(page).to have_content('3Lorem ipsum dolor set amet.')
      expect(page).to have_content('4Lorem ipsum dolor set amet.')
      expect(page).to have_content('5Lorem ipsum dolor set amet.')
    end
    it 'I can see a button that lets me view all of a user\'s posts.' do
      expect(page).to have_link('See all post')
    end
    it 'When I click a user\'s post, it redirects me to that post\'s show page.' do
      click_link 'Post #3'
      expect(page).to have_content('Post #3')
      expect(page).to have_content('3Lorem ipsum dolor set amet')
    end
    it 'When I click to see all posts, it redirects me to the user\'s post\'s index page' do
      click_link 'See all post'
      expect(page).to have_current_path(user_posts_path(User.first.id))
    end
  end
end
