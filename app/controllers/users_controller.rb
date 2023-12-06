class UsersController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def new
    @user = User.new
    @post_images = @user.post_images
  end
  
  
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page])
  end

  def edit
    @user =  User.find(params[:id])
    # is_matching_login_user
    # redirect_to user_path
  end

  def update
    # is_matching_login_user
    
    @user = User.find(params[:id])
    @user.update(user_params)
        # # 3. フラッシュメッセージを定義し、詳細画面へリダイレクト
        # flash[:notice] = "Book was successfully created."
    redirect_to user_path


  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
  end
end
