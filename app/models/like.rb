class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: :likes_counter

  def update_likes_counter
    post.increment!(:likesCounter)
  end
end
