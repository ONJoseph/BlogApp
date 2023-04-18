class PostsController < ApplicationController
  def index
    @user = User.includes(posts: :comments).find_by(id: params[:user_id])
    @posts = @user.posts.includes(:comments, :author)
  end

  def new
    @post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: @post } }
    end
  end

  def create
    @post = current_user.posts.create(post_params)

    if @post.save
      flash[:success] = 'Post created successfully!'
      redirect_to user_posts_path(current_user.id)
    else
      flash[:error] = 'An error occurred when creating the post!'
      render :new
    end
  end

  def show
    @post = Post.includes(:comments).find_by(id: params[:id])
    @user = User.find_by(id: params[:user_id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
