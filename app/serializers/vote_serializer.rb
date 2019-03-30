# frozen_string_literal: true

class VoteSerializer < ActiveModel::Serializer
  attributes :id, :value
  has_one :subscriber
  has_one :post
end
