class SearchController < ApplicationController
  def index
    if params[:q].nil?
      @posts = []
    else
      @posts = Post.elasticsearch(params[:q])
    end
    @posts_size = @posts.size
    @posts = @posts.page(params[:page]).per Settings.search.per_page
  end
end
