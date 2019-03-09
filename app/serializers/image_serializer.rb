# frozen_string_literal: true

class ImageSerializer < ActiveModel::Serializer
  attributes :id, :filename, :url, :darkness, :active, :used
end
