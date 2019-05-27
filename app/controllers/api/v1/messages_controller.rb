# frozen_string_literal: true

class Api::V1::MessagesController < ApplicationController
  def index
    render json: Message.where(message_params).send(
      { true => :active, false => :inactive, nil => :all }[params[:active]&.to_bool]
    )
  end

  def show
    render json: Message.find(params[:id])
  end

  private

  def message_params
    params.permit(:text, :darkness)
  end
end
