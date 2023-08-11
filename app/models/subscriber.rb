# frozen_string_literal: true

class Subscriber < ApplicationRecord
  has_many :votes, dependent: :destroy

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, uniqueness: { case_sensitive: false }, length: { in: 2..20 }, allow_nil: true, format: {
    with: /\A[a-z]+([a-z0-9!@#$^]+[-_. ]?)*[a-z0-9!]+\z/i
  }
  validates :active, inclusion: { in: [true, false] }

  def name
    super || email&.split('@', 2)&.first
  end

  def authorization
    JWT.encode({ email: }, Rails.application.secret_key_base, 'HS256')
  end
end
