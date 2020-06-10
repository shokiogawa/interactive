class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @posts = Post.where(user_id: current_user.following_ids).order(id: :desc).page(params[:page])
    
  end
  
  def show
    
    @post = Post.find(params[:id])
    @comment = Comment.new
    
    
    @comments = @post.comments.order(created_at: :desc)
    
    
  
  
    
    
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      redirect_to user_path(@post.user)
    else
      render :new
    end

  end

  def edit
    @post = current_user.posts.find_by(id: params[:id])
  end
  
  def update
    
    @post = current_user.posts.find_by(id: params[:id])
    
    
    if @post.update(post_params)
      flash[:success] = "編集しました"
      redirect_to user_path(@post.user)
    else
      flash.now[:danger] = "編集に失敗しました"
      render :edit
    end
      
  end

  def destroy
    @post.destroy
    flash[:success] = "削除しました"
    redirect_to user_path(@post.user)
    
    
    
  end
  
  private
  def post_params
    params.require(:post).permit(:content, :title, {:category_ids => []})
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
     redirect_to root_url
    end
  end
end
