# frozen_string_literal: true

module Api
  module V1
    class ReportsController < ApplicationController
      def index
        render json: Report.all
      end

      def show
        render json: Report.find(params[:id])
      end
    end
  end
end
