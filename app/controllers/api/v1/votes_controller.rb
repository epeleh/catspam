# frozen_string_literal: true

class Api::V1::VotesController < ApplicationController
  before_action :check_authorization!

  def index
    render json: Vote.where(subscriber: @current_user).where(vote_params)
  end

  def show
    render json: Vote.where(subscriber: @current_user).find(params[:id])
  end

  def create
    @post = Post.find_by_id(params[:post_id])
    return head :gone if @post.present? && !@post.active?

    @previous_vote = Vote.find_by(post_id: params[:post_id], subscriber_id: @current_user.id)

    if @previous_vote.present?
      if @previous_vote.update(vote_params)
        render json: @previous_vote
      else
        render json: @previous_vote.errors, status: :unprocessable_entity
      end
    else
      @vote = Vote.new(vote_params.merge(subscriber_id: @current_user.id))
      if @vote.save
        render json: @vote, status: :created
      else
        render json: @vote.errors, status: :unprocessable_entity
      end
    end
  end

  private

  def vote_params
    params.permit(:post_id, :value)
  end
end
