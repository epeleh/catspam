# frozen_string_literal: true

class SubscribersController < ApplicationController
  before_action :check_authorization!, only: %i[update]

  def index
    render json: Subscriber.where(subscriber_params)
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
    return head :unauthorized if @current_user != @subscriber

    if @subscriber.update(subscriber_params)
      render json: @subscriber
    else
      render json: @subscriber.errors, status: :unprocessable_entity
    end
  end

  private

  def subscriber_params
    params.permit(:email, :name, :active)
  end
end
