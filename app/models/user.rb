class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  validates :name, :bio, :email, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }

  has_many :comments, dependent: :destroy, foreign_key: 'user_id'
  has_many :likes, dependent: :destroy, foreign_key: 'user_id'
  has_many :posts, dependent: :destroy, foreign_key: 'user_id'

  def my_recent_posts
    posts.limit(3).order(created_at: :desc)
  end
end
