# frozen_string_literal: true

class VoteSerializer < ActiveModel::Serializer
  attributes :id, :value, :created_at, :updated_at
  has_one :subscriber
  has_one :post
end
