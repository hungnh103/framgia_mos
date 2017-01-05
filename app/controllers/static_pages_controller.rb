class StaticPagesController < ApplicationController
  def home
    @first_post = Post.where(status: [:admin_create, :accepted])
      .order(created_at: :desc).first
  end
end
