require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.feature 'Post #Index', type: :feature do
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

  scenario "show user's profile picture" do
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    expect(find('img') do |img|
             img[:src] == 'https://www.w3schools.com/w3images/avatar2.png'
           end).to be_truthy
  end

  scenario "show user's name" do
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    expect(page).to have_content 'Elik'
  end

  scenario 'show number of posts per user' do
    Post.create(title: 'Bla bla bla', text: 'Bla bla bla', author_id: @user1.id)
    Post.create(title: 'Bla bla bla', text: 'Bla bla bla', author_id: @user1.id)

    find("a[href='#{user_path(@user1.id)}']").click
    find("a[href='#{user_posts_path(@user1.id)}']").click
    expect(page).to have_content "Number of posts: #{@user1.posts.size}"
  end

  scenario 'show the first comments on a post.' do
    @post = Post.create(title: 'Bla bla bla', text: 'Bla bla bla',
                        author_id: @user1.id)
    @comment = Comment.create(text: 'Bla bla bla', author_id: @user1.id,
                              post_id: @post.id)

    find("a[href='#{user_path(@user1.id)}']").click
    find("a[href='#{user_posts_path(@user1.id)}']").click
    expect(page).to have_content 'Bla bla bla'
  end

  scenario 'show how many likes a post has.' do
    @post = Post.create(title: 'Bla bla bla', text: 'Bla bla bla',
                        author_id: @user1.id)
    Like.create(author_id: @user1.id, post_id: @post.id)
  end

  scenario "click on post and redirect to that post's show page." do
    @post = Post.create(title: 'Bla bla bla', text: 'Bla bla bla', author_id: @user1.id)
    find("a[href='#{user_path(@user1.id)}']").click
    find("a[href='#{user_posts_path(@user1.id)}']").click
    find("a[href='#{user_post_path(@user1.id, @post.id)}']").click
    expect(page).to have_current_path(user_post_path(@user1.id, @post.id))
  end
  # rubocop:enable Metrics/BlockLength
end
