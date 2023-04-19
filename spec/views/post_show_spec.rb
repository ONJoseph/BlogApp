require 'rails_helper'

RSpec.describe 'Users index page', type: :feature do
  before(:example) do
    @user = User.create(name: 'Tom',
                        photo: 'https://e7.pngegg.com/pngimages/178/595/png-clipart-user-profile-computer-icons-login-user-avatars-monochrome-black.png',
                        bio: 'Teacher from Mexico.')
    @post = Post.create(author: @user, title: 'Hello1', text: 'post1')
    @comment = Comment.create(author: @user, post: @post, text: 'my comment')
  end

  context 'When viewing a post' do
    before { visit user_post_path(@user, @post) }

    it 'displays the post title' do
      expect(page).to have_content('Hello1')
    end

    it 'displays the post author' do
      expect(page).to have_content('by Tom')
    end

    it 'displays the post body' do
      expect(page).to have_content('post1')
    end

    it 'displays the comments section' do
      expect(page).to have_content('Comments:')
    end

    it 'displays the number of comments' do
      expect(page).to have_content('1')
    end

    it 'displays the commenter name' do
      expect(page).to have_content('Tom')
    end

    it 'displays the comment text' do
      expect(page).to have_content('my comment')
    end

    it 'displays the likes section' do
      expect(page).to have_content('Likes:')
    end

    it 'displays the number of likes' do
      expect(page).to have_content('0')
    end
  end

  context 'When clicking on a post' do
    before do
      visit user_posts_path(@user)
      click_link('Hello1')
    end

    it 'redirects to the post show page' do
      expect(page).to have_current_path(user_post_path(@user, @post))
    end
  end
end
