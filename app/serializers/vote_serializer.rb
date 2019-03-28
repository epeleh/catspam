# frozen_string_literal: true

class VoteSerializer < ActiveModel::Serializer
  attributes :id, :subscriber_id, :post_id, :value
end
