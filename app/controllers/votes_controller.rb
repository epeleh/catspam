# frozen_string_literal: true

class VotesController < ApplicationController
  def create; end

  private

  def vote_params
    params.fetch(:vote, {})
  end
end
