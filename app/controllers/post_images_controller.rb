class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end

   # 投稿データの保存
  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    @post_image.save
    redirect_to post_images_path
  end

  def index
    @post_images = PostImage.page(params[:page])
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end
  
  # def destroy
  #   post_image = 削除するPostImageレコードを取得
  #   post_image.削除
  #   redirect_to PostImageの一覧ページへのパス
  # end
  
  def destroy
    post_image = PostImage.find(params[:id])  # データ（レコード）を1件取得
    post_image.destroy  # データ（レコード）を削除
    flash[:notice] = "Book was successfully created."
    redirect_to post_images_path  # 投稿一覧画面へリダイレクト  
  end
  
  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      redirect_to post_images_path
    else
      render :new
    end
  end
  
  # 投稿データのストロングパラメータ
  private

  def post_image_params
    params.require(:post_image).permit(:shop_name, :image, :caption)
  end
end
