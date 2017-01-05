class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_category_roots, :load_favourite_posts, :load_recent_posts

  rescue_from Exception do |exception|
    flash[:warning] = exception.message
    redirect_to_root
  end

  private

  def redirect_to_root
    (current_admin_user && namespace == "admin") ?
      redirect_to(admin_root_url) : redirect_to(root_url)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit :name, :user_name,
      :sex, :birthday, :phone_number, :address, :status, :email, :password,
      :password_confirmation, :avatar}
    devise_parameter_sanitizer.permit(:account_update) {|u| u.permit :name,
      :user_name, :sex, :birthday, :email, :password, :current_password,
      :phone_number, :address, :status, :avatar, :password_confirmation}
  end

  def load_category_roots
    @category_roots = Category.roots.includes(:posts)
  end

  def load_favourite_posts
    @favourite_posts = Post.where(status: [:admin_create, :accepted])
      .order(likes_count: :desc)
      .limit Settings.static_pages.home.favourite_posts_size
  end

  def load_recent_posts
    @recent_posts = Post.where(status: [:admin_create, :accepted])
      .order(created_at: :desc).drop(1)
      .take Settings.static_pages.number_hot_posts
  end

  def current_ability
    Ability.new(current_user, namespace.camelize)
  end

  def namespace
    controller_name_segments = params[:controller].split("/")
    controller_name_segments.pop
    controller_name_segments.join("/")
  end
end
