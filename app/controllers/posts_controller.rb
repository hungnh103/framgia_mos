class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :load_all_categories, only: [:new, :edit]

  def new
  end

  def create
    if @post.save
      flash[:success] = t ".success"
      redirect_to current_user
    else
      load_all_categories
      render :new
    end
  end

  def show
    redirect_to root_url unless @post.accepted? || (@post.user == current_user)
    @total_like = @post.likes.size
  end

  def edit
    redirect_to root_url unless @post.pending?
  end

  def update
    if @post.update_attributes post_params
      flash[:success] = t ".success"
      redirect_to current_user
    else
      load_all_categories
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to current_user
  end

  private

  def load_all_categories
    @nested_categories = Category.all_categories @category_roots
  end

  def post_params
    params.require(:post).permit :id, :title, :description, :category_id,
      :content, :image, :audio, :user_id, :post_type, :status
  end
end
