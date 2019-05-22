# frozen_string_literal: true

class PostsController < ApplicationController
  def show
    @post = Post.find_by_id(params[:id])
    redirect_to root_url if @post.nil?
  end
end
