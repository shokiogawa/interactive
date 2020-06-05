class CommentsController < ApplicationController
  before_action :require_user_logged_in

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    
    @comments = @post.comments.order(created_at: :desc)
  
  end
   
    

  def destroy
    @comment = current_user.comments.find_by(id: params[:id])
    @comment.destroy 
    flash[:success] = "削除しました"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end
