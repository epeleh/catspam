# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  attributes :id, :stars, :weekday, :active?, :created_at
  has_one :image
  has_one :message
  has_one :report
end
