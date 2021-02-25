class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_post, only: %i[show destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path
      flash[:success] = '投稿が保存されました'
    else
      render :new
    end
  end

  def index
    @posts = Post.limit(10).includes(:category, :user).order('created_at DESC')
  end

  def show; end

  def destroy
    if @post.user == current_user && @post.destroy
      # リクエスト元情報の取得
      @path = Rails.application.routes.recognize_path(request.referer)
      # リクエスト元がプロフィール画面の場合
      if @path[:controller] == 'users' && @path[:action] == 'show'
        respond_to do |format|
          format.js { flash.now[:error] = '投稿を削除しました' }
        end
      else
        # リクエスト元が画像詳細画面の場合
        redirect_to root_path
        flash[:error] = '投稿を削除しました'
      end
    else
      redirect_to root_path
      flash[:error] = '投稿の削除に失敗しました'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :caption, :photo, :photo_cache, :category_id).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end
end
