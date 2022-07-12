class PostsController < ApplicationController
  
  def index
    @post = Post.all
  end

  def show
  
   @post = Post.find(params[:id])
   @comments = @post.comments
   @photo = @post.photos.paginate(page: params[:page], per_page: 1)

  end

  def edit
    @post = Post.new
  end

  def update
     #byebug
     @post = Post.find(params[:id])
     @post.update(caption: params[:post][:caption])
     redirect_to root_path
  end

  def new
    @post = Post.new
  end

  def create
    #byebug
    @post = current_user.posts.new(caption: params[:post][:caption])
     @post.save
     params[:post][:avatar].each do |photo|
           @photu = @post.photos.create(avatar: photo)
         end
    redirect_to root_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end
  def create_comment
    #byebug
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(feedback: params[:feedback], user_id: current_user.id)
    @comment.save
    @comments = @post.comments

  end
  
  def destroy_comment
    # byebug
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    @comment.destroy
    @comments = @post.comments
  end

  def like_dislike
     @comment = Comment.find(params[:comment_id])
     if params[:like] == "true"
         @like = @comment.likes.new(user_id: current_user.id)
         @like.save
     else
         @comment.likes.find_by(user_id:current_user.id).destroy
     end
  end

  def like_post
    byebug
  end
  
end
