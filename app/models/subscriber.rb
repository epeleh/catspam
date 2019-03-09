# frozen_string_literal: true

class Subscriber < ApplicationRecord
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
end
