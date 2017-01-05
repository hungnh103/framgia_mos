class Admin::PostsController < Admin::BaseController
  load_and_authorize_resource
  before_action :load_all_categories, only: [:index, :show]

  def index
    @search = Post.all.ransack params[:q]
    @categories_for_select = Category.pluck(:name, :id)
    @users_for_select = User.pluck(:name, :id)
    @posts = @search.result.order(created_at: :desc).page(params[:page])
      .per Settings.admin.posts.per_page
    @post = Post.new
  end

  def show
  end

  def create
    if @post.save
      flash[:success] = t ".success"
      redirect_to admin_posts_path
    else
      @search = Post.all.ransack params[:q]
      @categories_for_select = Category.pluck(:name, :id)
      @users_for_select = User.pluck(:name, :id)
      @posts = @search.result.order(created_at: :desc).page(params[:page])
        .per Settings.admin.posts.per_page
      load_all_categories
      render :index
    end
  end

  def update
    if @post.update_attributes post_params
      flash[:success] = t ".success"
      redirect_to :back
    else
      load_all_categories
      render :show
    end
  end

  def destroy
    ids = params[:post_ids].nil? ? params[:id] : params[:post_ids]
    if params[:post_ids].present?
      authorize! :destroy_all, Post
    end

    if ids.nil?
      flash[:danger] = t ".must_select"
    else
      @posts = Post.find ids
      if Post.destroy @posts
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".fail"
      end
    end
    redirect_to admin_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:id, :title, :description, :category_id,
      :content, :image, :audio, :user_id, :post_type, :status)
  end

  def load_all_categories
    @nested_categories = Category.all_categories @category_roots
  end
end
