# frozen_string_literal: true

class SubscribersController < ApplicationController
  def index
    render json: Subscriber.all
  end

  def show
    render json: Subscriber.find(params[:id])
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      render json: @subscriber, status: :created
    else
      render json: @subscriber.errors, status: :unprocessable_entity
    end
  end

  def update
    @subscriber = Subscriber.find(params[:id])
    if @subscriber.update(subscriber_params)
      render json: @subscriber, status: :ok
    else
      render json: @subscriber.errors, status: :unprocessable_entity
    end
  end

  private

  def subscriber_params
    params.permit(:email, :name, :active)
  end
end
