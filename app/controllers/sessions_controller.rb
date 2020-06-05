class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      remember(@user)
      flash[:success] = "ログインしました"
      redirect_to user_path(current_user)
    else 
      flash[:danger] = "ログインに失敗しました"
      render :new
    end
    
  end

  def destroy
    log_out if logged_in?
    
    #session[:user_id] = nil
    #flash[:success] = "ログアウトしました"
    redirect_to root_url
  end
  
  private
   def login(email, password)
     @user = User.find_by(email: email)
     if @user && @user.authenticate(password)
       session[:user_id] = @user.id
       return true
     else
       return false
     end
   end
   
   def remember(user)
     user.remember
     cookies.permanent.signed[:user_id] = user.id
     cookies.permanent[:remember_token] = user.remember_token
   end
  
  
  
  
  
end
