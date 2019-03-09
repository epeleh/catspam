# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  attributes :id, :message, :created_at
  has_one :image
end
