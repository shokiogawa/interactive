class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(14)
    @posts = Post.order(id: :desc).page(params[:page]).per(14)
    
    
    
      
   
  end

  def show
    @user = User.find(params[:id])
    @post = @user.posts.order(id: :desc).page(params[:page]).per(14)
    
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ユーザーを登録しました"
      redirect_to login_path
    else
      flash.now[:danger]= "ユーザーの登録に失敗しました"
      render :new
    end
    
    
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params1)
      flash[:success] ="編集に成功しました"
      redirect_to @user
    else
      flash.now[:danger] = "編集に失敗しました"
      render :edit
    end
  end

  def destroy
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
  
  def user_params1
    params.require(:user).permit(:name, :lang1, :lang2, :profile, :image)
  end
  
  
end
