RSpec.describe Post, type: :model do
  let(:post) { Post.new(author:, title: 'Hello', text: 'This is my first post') }
  let(:author) { User.new(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  before do
    post.save
    author.save
  end

  # ...

  context 'When checking for the first five recent comments' do
    before do
      8.times { Comment.create(author:, post:, text: 'my comment') }
    end

    it 'five_most_recent_comments should return only the first five recent comments' do
      comments = post.five_most_recent_comments
      expect(comments.length).to eq(5)
    end
  end
end
