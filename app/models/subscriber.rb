# frozen_string_literal: true

class Subscriber < ApplicationRecord
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  before_validation :set_cache

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, uniqueness: true, format: { with: /\A[\w\s]*[a-z]+\z/i }, length: { in: 2..20 }, allow_nil: true
  validates :active, inclusion: { in: [true, false] }
  validates :cache, presence: true, uniqueness: true, length: { is: 42 }

  private

  def set_cache
    return if cache

    self.cache = SecureRandom.hex(42 / 2)
    self.cache = SecureRandom.hex(42 / 2) while Subscriber.pluck(:cache).include?(cache)
  end
end
