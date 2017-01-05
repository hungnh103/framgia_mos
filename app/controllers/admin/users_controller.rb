class Admin::UsersController < Admin::BaseController
  load_resource

  def index
    authorize! :read, User
    @search = User.all.ransack params[:q]
    @users = @search.result.order(:name).page(params[:page])
      .per Settings.admin.users.per_page
  end

  def update
    if params[:user][:status].present?
      authorize! :block, @user
    end
    if @user.update_attributes user_params
      flash[:success]= t ".success"
    else
      flash[:danger]= t ".error"
    end
      redirect_to admin_users_url
  end

  private

  def user_params
    params.require(:user).permit :id, :status
  end
end
