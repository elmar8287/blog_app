class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: :comments_counter

  def update_comments_counter
    post.increment!(:commentsCounter)
  end
end
