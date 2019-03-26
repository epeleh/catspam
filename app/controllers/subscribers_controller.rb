# frozen_string_literal: true

class SubscribersController < ApplicationController
  def index
    render json: Subscriber.all
  end

  def show
    render json: Subscriber.find(params[:id])
  end

  def create
  end

  def update
  end
end
