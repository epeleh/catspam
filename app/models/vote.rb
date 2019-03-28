# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :subscriber
  belongs_to :post

  validates :value, presence: true, inclusion: { in: 1..10 }
  validates :post_id, uniqueness: { scope: :subscriber_id }
end
