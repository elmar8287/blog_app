require 'rails_helper'
RSpec.feature 'User #Show', type: :feature do
  background do
    visit new_user_session_path
    @user1 = User.create(name: 'Elik', bio: 'Here is short bio',
                         photo: 'https://www.w3schools.com/w3images/avatar2.png',
                         email: 'L-mar@inbox.ru', password: 'password', confirmed_at: Time.now)

    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
  end

  scenario 'show number of posts per user' do
    Post.create(title: 'Bla Bla Blashka', text: 'TBla Bla Blashka', author_id: @user1.id)
    Post.create(title: 'Bla Bla Blashka', text: 'Bla Bla Blashka', author_id: @user1.id)

    find("a[href='#{user_path(@user1.id)}']").click
    expect(page).to have_content 'Number of posts: 2'
  end

  scenario "show user's bio." do
    Post.create(title: 'Bla Bla Blashka', text: 'Bla Bla Blashka', author_id: @user1.id)

    find("a[href='#{user_path(@user1.id)}']").click
    expect(page).to have_content 'Bla Bla Blashka'
  end

  scenario "show user's first 3 posts." do
    Post.create(title: 'Post 1', text: 'Bla Bla Blashka', author_id: @user1.id)
    Post.create(title: 'Post 2', text: 'Bla Bla Blashka', author_id: @user1.id)
    Post.create(title: 'Post 3', text: 'Bla Bla Blashka', author_id: @user1.id)
    Post.create(title: 'Post 4', text: 'Bla Bla Blashka', author_id: @user1.id)
    find("a[href='#{user_path(@user1.id)}']").click
    expect(page).to_not have_content 'ku ku ku'
  end
end
