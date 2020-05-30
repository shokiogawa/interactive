class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @user = User.find(params[:follow_id])
    current_user.follow(@user)
    #respond_to do |format|
      #format.html {redirect_to @user}
      #format.js
    #end
  end
    
    
    
    
   # flash[:success] ="フォローしました"
    #redirect_to user
    #end

  def destroy
    @user = User.find(params[:follow_id])
    current_user.unfollow(@user)
    #respond_to do |format|
      #format.html {redirect_to @user}
      #format.js
    #end
  end
    
    
    #flash[:danger] = "フォローを解除しました"
    #redirect_to user
    #end
end
