# frozen_string_literal: true

class Api::V1::PostsController < ApplicationController
  def index
    render json: Post.where(post_params).send(
      { true => :active, false => :inactive, nil => :all }[params[:active]&.to_bool]
    ).select { |x| params[:weekday].blank? || x.weekday&.casecmp?(params[:weekday]) }
  end

  def show
    render json: Post.find(params[:id])
  end

  private

  def post_params
    params.permit(:report_id, :image_id, :message_id)
  end
end
