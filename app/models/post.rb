class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  def update_posts_counter
    user.increment!(:postsCounter)
  end

  def recent_comments
    comments.limit(5).order(created_at: :desc)
  end

  validates :title, length: { maximum: 250 }
  validates :comments_counter, :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
