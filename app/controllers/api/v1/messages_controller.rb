# frozen_string_literal: true

module Api
  module V1
    class MessagesController < ApplicationController
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
  end
end
