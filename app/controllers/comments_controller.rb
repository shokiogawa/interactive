class CommentsController < ApplicationController
  before_action :require_user_logged_in

  def create
    # 下記の処理をcontollerで行っています。
    # 1. 送られてきたpost_idと合致するpostを探し、postの変数へ代入します
    # 2. post.comment.build~でcommentの変数を作成します(この時点でpost_idがcommentの値へ挿入される。ただ、user_idがまだわからない。ちなみにcommentの作成にはuser_idとpost_idが必要)
    # 3. commentへuser_idの値を挿入します(送られてきたパラメーターから取得してくる。)
    # 4. commentを保存します
    
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    
    @comments = @post.comments.order(created_at: :desc)
  
   
    #if @comment.save
      #flash[:success] = "コメントを追加しました"
      #redirect_back(fallback_location: root_path)
    #end
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
