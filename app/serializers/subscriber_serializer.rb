# frozen_string_literal: true

class SubscriberSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :active, :created_at, :updated_at
end
