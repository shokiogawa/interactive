class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [ :show]
  before_action :current_user_now, only: [:edit]
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers]
  
  def index
     if logged_in?
     @recommends = User.where(language_id: current_user.language1&.id, language1_id: current_user.language&.id ).sample(4)
     end
    
    @language = Language.find_by(id: params[:language_id])
    if @language
      @user1 = @language.users.page(params[:page]).per(14)
      @count_languages = @language.users.count
      respond_to do |format|
        format.html
        format.js
      end
    else
      @users = User.order(id: :desc).page(params[:page]).per(14)
    end


      
    
    
    @category = Category.find_by(id: params[:category_id])
    
    if @category
      @posts = @category.posts.page(params[:page]).per(8)
    else
      @posts = Post.order(id: :desc).page(params[:page]).per(8)
    end
    
    
    
    
    
      
   
  end

  def show
    
    @posts = @user.posts.order(id: :desc).page(params[:page]).per(14)
    counts(@user)
    
    @post = current_user.posts.build
    
    respond_to do |format|
        format.html
        format.js
      end
    
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
   
  end

  def update
    
    
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
    
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :language_id, :language1_id)
  end
  
  def user_params1
    params.require(:user).permit(:name, :lang1, :profile, :image, :language_id, :language1_id)
  end
  
 def current_user_now
   @user = User.find(params[:id])
   
   unless @user == current_user
     redirect_to root_url
   end
 end
 
 def set_user
   @user = User.find(params[:id])
 end
   
  
  
end
