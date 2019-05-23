# frozen_string_literal: true

class Api::V1::ImagesController < ApplicationController
  def index
    render json: Image.where(image_params).send(
      { true => :active, false => :inactive, nil => :all }[params[:active]&.to_bool]
    )
  end

  def show
    render json: Image.find(params[:id])
  end

  private

  def image_params
    params.permit(:darkness)
  end
end
