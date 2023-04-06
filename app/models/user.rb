class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes

  def post_count
    posts.count
  end
end
