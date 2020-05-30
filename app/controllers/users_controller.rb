class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  
  
  def index
   
    
    
    @language = Language.find_by(id: params[:language_id])
    
    if @language
      @users = @language.users.page(params[:page]).per(14)
    else
       @users = User.order(id: :desc).page(params[:page]).per(14)
    end

      
    
    
    @category = Category.find_by(id: params[:category_id])
    
    if @category
      @posts = @category.posts.page(params[:page]).per(14)
    else
      @posts = Post.order(id: :desc).page(params[:page]).per(14)
    end
    

    counts(User.first)
    
    
      
   
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page]).per(14)
    counts(@user)
    
    @post = current_user.posts.build
    
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
    params.require(:user).permit(:name, :lang1, :profile, :image, :language_id)
  end
  
  
end
