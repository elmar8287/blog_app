require 'rails_helper'
RSpec.describe 'showing the list of user\'s last published posts', type: :feature do
  describe 'index page:' do
    before do
      visit new_user_session_path
      @elik = User.create(name: 'Elik', bio: 'Bla bla', email: 'elik@mail.com',
                           password: '123456', password_confirmation: '123456', confirmed_at: Date.today)
      @velik = User.create(name: 'Velik', bio: 'Bla bla', email: 'velik@mail.com', password: '123456',
                          password_confirmation: '123456', confirmed_at: Date.today)

      5.times do |j|
        post = Post.create(title: "Post ##{j + 1}", text: "#{j + 1}Lorem ipsum dolor set amet.", author: @elik)
        Comment.create(text: 'Random comment', post: post, author: @elik)
        Comment.create(text: 'Random comment', post: post, author: @velik)
      end

      fill_in 'Email', with: 'elik@mail.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      visit "/users/#{@elik.id}/posts/"
    end

    it 'I can see the user\'s profile picture.' do
      expect(page).to have_css('img.users-image')
    end

    it 'I can see the user\'s username.' do
      expect(page).to have_content('Elik')
    end

    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content('Number of posts: 5')
    end

    it 'I can see the post\'s title' do
      expect(page).to have_content('Post #1')
    end

    it 'I can see some of the post\'s body.' do
      expect(page).to have_content('Lorem ipsum dolor set amet.')
    end

    it 'I can see the first comments on a post.' do
      expect(page).to have_content('Random comment')
    end

    it 'I can see how many comments a post has.' do
      expect(page).to have_content('Comments: 2')
    end

    it 'I can see how many likes a post has.' do
      expect(page).to have_content('Likes: 0')
    end

    it 'I can see a section for pagination if there are more posts than fit on the view.' do
      expect(page).to have_button('Pagination')
    end

    it 'When I click on a post, it redirects me to that post\'s show page.' do
      click_link 'Post #1'
      expect(page).to have_current_path(user_post_path(@elik.id, @elik.posts.first.id))
    end
  end
end
