class User < ActiveRecord::Base

  validates :name, presence: true
  validates :password, presence: true, confirmation: true
  has_many :followings
  has_many :followers, through: :followings
  has_many :posts

  scope :following, -> (current_user) { joins(:followings).where('follower_id = ?', current_user) }

  def self.create_user_with_messages(user_name, password, messages)
    u = create(name: user_name, password: password)
    posts.each do |post|
      u.posts.create post: post
    end
    u
  end
end
