# frozen_string_literal: true

class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text, :darkness, :active?, :created_at, :updated_at
end
