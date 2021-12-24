require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.feature 'Posts #Show', type: :feature do
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

  scenario 'show post title.' do
    @post = Post.create(title: 'Bla bla Bla', text: 'Bla bla Bla', author_id: @user1.id)
    find("a[href='#{user_path(@user1.id)}']").click
    find("a[href='#{user_posts_path(@user1.id)}']").click
    find("a[href='#{user_post_path(@user1.id, @post.id)}']").click
    expect(page).to have_content 'Bla bla Bla'
  end

  scenario 'show post author' do
    @post = Post.create(title: 'Bla bla Bla', text: 'Bla bla Bla', author_id: @user1.id)
    find("a[href='#{user_path(@user1.id)}']").click
    find("a[href='#{user_posts_path(@user1.id)}']").click
    find("a[href='#{user_post_path(@user1.id, @post.id)}']").click
    expect(page).to have_content @user1.name
  end

  scenario 'show how many comments a post has.' do
    @post = Post.create(title: 'Bla bla Bla', text: 'Bla bla Bla.', author_id: @user1.id)
    @comment1 = Comment.create(text: 'Bla bla Bla', author_id: @user1.id,
                               post_id: @post.id)
    find("a[href='#{user_path(@user1.id)}']").click
    find("a[href='#{user_posts_path(@user1.id)}']").click
    find("a[href='#{user_post_path(@user1.id, @post.id)}']").click
    expect(page).to have_content 'Comments : 1'
  end

  scenario 'show how many likes a post has.' do
    @post = Post.create(title: 'Bla bla Bla', text: 'Bla bla Bla', author_id: @user1.id)
    Like.create(author_id: @user1.id, post_id: @post.id)
    find("a[href='#{user_path(@user1.id)}']").click
    find("a[href='#{user_posts_path(@user1.id)}']").click
    find("a[href='#{user_post_path(@user1.id, @post.id)}']").click
    expect(page).to have_content 'Likes : 1'
  end

  scenario 'show body of the post' do
    @post = Post.create(title: 'Bla bla Bla', text: 'Bla bla Bla', author_id: @user1.id)

    find("a[href='#{user_path(@user1.id)}']").click
    find("a[href='#{user_posts_path(@user1.id)}']").click
    find("a[href='#{user_post_path(@user1.id, @post.id)}']").click
    expect(page).to have_content @post.text
  end

  scenario 'show comments that have been made' do
    @post = Post.create(title: 'Bla bla Bla', text: 'Bla bla Bla', author_id: @user1.id)
    @comment1 = Comment.create(text: 'Bla bla Bla', author_id: @user1.id,
                               post_id: @post.id)
    find("a[href='#{user_path(@user1.id)}']").click
    find("a[href='#{user_posts_path(@user1.id)}']").click
    find("a[href='#{user_post_path(@user1.id, @post.id)}']").click
    expect(page).to have_content @comment1.text
  end
  # rubocop:enable Metrics/BlockLength
end
