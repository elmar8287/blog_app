require 'rails_helper'
RSpec.describe 'showing the user\'s post', type: :feature do
  describe 'show page:' do
    before do
      visit new_user_session_path
      @elik = User.create(name: 'Elik', bio: 'Blabla', email: 'Elik@mail.com',
                          password: '123456', password_confirmation: '123456', confirmed_at: Date.today)
      @velik = User.create(name: 'Velik', bio: 'Blabla', email: 'Velik@mail.com', password: '123456',
                           password_confirmation: '123456', confirmed_at: Date.today)

      5.times do |j|
        post = Post.create(title: "Post ##{j + 1}", text: "#{j + 1}Lorem ipsum dolor set amet.", author: @elik)
        Comment.create(text: 'Random comment', post: post, author: @elik)
        Comment.create(text: 'Random comment', post: post, author: @velik)
      end

      fill_in 'Email', with: 'Elik@mail.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      click_link 'Elik'
      click_link 'See all post'
      click_link 'Post #1'
    end

    it 'I can see the post\'s title.' do
      expect(page).to have_content('Post #1')
    end

    it 'I can see who wrote the post.' do
      expect(page).to have_content('Post #1')
      expect(page).to have_content('by')
      expect(page).to have_content('Elik')
    end

    it 'I can see how many comments it has.' do
      expect(page).to have_content('Comments: 2')
    end

    it 'I can see how many likes a post has.' do
      expect(page).to have_content('Likes: 0')
    end

    it 'I can see the post body.' do
      expect(page).to have_content('Lorem ipsum dolor set amet.')
    end

    it 'I can see the username of each commentor.' do
      expect(page).to have_content('Velik')
      expect(page).to have_content('Elik')
    end
    it 'I can see the comment each commentor left' do
      expect(page).to have_content('Velik: Random comment')
      expect(page).to have_content('Elik: Random comment')
    end
  end
end
