# frozen_string_literal: true

class ImagesController < ApplicationController
  def index
    render json: Image.all
  end

  def show
    render json: Image.find(params[:id])
  end
end
