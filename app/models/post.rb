class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: :posts_counter
  has_many :likes, dependent: :destroy, foreign_key: 'post_id'
  has_many :comments, dependent: :destroy, foreign_key: 'post_id'

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def last_comments
    comments.last(5)
  end

  private

  def update_post_counter
    author.update!(:posts_counter)
  end
end
