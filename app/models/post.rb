class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_save :update_post_count

  def five_most_recent_comments
    comments.order(created_at: :desc).first(5)
  end

  private

  def update_post_count
    author.increment!(:post_count)
    update_column(:post_count, author.post_count)
  end

  attribute :post_count, :integer, default: 0
end
