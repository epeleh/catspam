# frozen_string_literal: true

class Api::V1::ImagesController < ApplicationController
  def index
    render json: Image.where(image_params).send(
      { true => :used, false => :not_used, nil => :all }[params[:used]&.to_bool]
    )
  end

  def show
    render json: Image.find(params[:id])
  end

  private

  def image_params
    params.permit(:darkness, :active)
  end
end
