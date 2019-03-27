# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_current_user

  private

  def set_current_user
    @current_user = Subscriber.find_by_cache(params[:cache])
  end
end
