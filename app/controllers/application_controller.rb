class ApplicationController < ActionController::Base
    
    include SessionsHelper
    
  def counts(user)
    @count_followings = user.followings.size
    @count_followers = user.followers.size
   #@count_users =  User.count
    
  end
  
  
  
 
  
    
    private
    def require_user_logged_in
        unless logged_in?
        redirect_to login_url
        end
    end
    
    
    
    
    
end
