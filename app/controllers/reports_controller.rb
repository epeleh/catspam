# frozen_string_literal: true

class ReportsController < ApplicationController
  def show
    @report = Report.includes(posts: [:message, votes: :subscriber, image: { file_attachment: :blob }])
                    .find_by_id(params[:id])

    redirect_to root_url if @report.nil?
  end
end
