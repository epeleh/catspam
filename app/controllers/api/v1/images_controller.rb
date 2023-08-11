# frozen_string_literal: true

module Api
  module V1
    class ImagesController < ApplicationController
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
  end
end
