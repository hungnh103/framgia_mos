class ConfessionsController < ApplicationController
  load_resource

  def index
    @confessions = Confession.accepted.order(updated_at: :desc)
      .page(params[:page]).per Settings.confessions.per_page
    @confession = Confession.new
  end

  def create
    if @confession.save
      flash[:success] = t ".success"
    else
      flash[:error] = t ".fail"
    end
    redirect_to confessions_url
  end

  private
  def confession_params
    params.require(:confession).permit :content
  end
end
