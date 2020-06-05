class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    
    
    @user = User.find(params[:follow_id])
    current_user.follow(@user)
    
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
    
    
    #flash[:success] = 'ユーザをフォローしました。'
    #redirect_to root_url
    
  end
    

  def destroy
    @user = User.find(params[:follow_id])
    current_user.unfollow(@user)
    #respond_to do |format|
      #format.html {redirect_to @user}
      #format.js
    #end
    #flash[:success] = 'ユーザのフォローを解除しました。'
    #redirect_to root_url
  end
    
end
