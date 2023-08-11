# frozen_string_literal: true

class PostsController < ApplicationController
  def show
    @post = Post.includes(:message, image: { file_attachment: :blob }).find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
