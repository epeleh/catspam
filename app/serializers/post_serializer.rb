# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  attributes :id, :message, :weekday, :active?, :created_at
  has_one :report
  has_one :image
end
