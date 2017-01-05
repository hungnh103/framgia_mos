class Admin::AdvertismentsController < Admin::BaseController
  load_and_authorize_resource

  def index
    @advertisment = Advertisment.new
    load_advertisments
  end

  def show
  end

  def create
    if @advertisment.save
      flash[:success] = t ".success"
      redirect_to admin_advertisments_path
    else
      flash[:danger] = t ".fail"
      load_advertisments
      render :index
    end
  end

  def update
    if @advertisment.update_attributes advertisment_params
      flash[:success] = t ".success"
      redirect_to [:admin, @advertisment]
    else
      render :show
    end
  end

  def destroy
    ids = params[:advertisment_ids].nil? ? params[:id] : params[:advertisment_ids]

    if params[:post_ids].present?
      authorize! :destroy_all, Advertisment
    end

    if ids.nil?
      flash[:danger] = t ".must_select"
    else
      @advertisments = Advertisment.find ids
      if Advertisment.destroy @advertisments
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".fail"
      end
    end
    redirect_to admin_advertisments_path
  end

  private

  def load_advertisments
    @search = Advertisment.ransack params[:q]
    @advertisments = @search.result.page(params[:page])
      .per Settings.admin.categories.per_page
  end

  def advertisment_params
    params.require(:advertisment).permit :description, :url, :image
  end
end
