# frozen_string_literal: true

class Api::V1::InviteController < ApplicationController
  def send
    # TODO
  end

  private

  def invite_params
    params.permit(:email, :name, :type)
  end
end
