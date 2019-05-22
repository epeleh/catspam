# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :set_current_user

  private

  def check_authorization!
    head :unauthorized if @current_user.nil?
  end

  def set_current_user
    token = request.headers['Authorization'] || cookies['Authorization']
    email = JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256').first['email']
    @current_user = Subscriber.find_by_email(email)
  rescue StandardError
    nil
  end
end
