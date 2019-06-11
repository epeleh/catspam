# frozen_string_literal: true

class Subscriber < ApplicationRecord
  has_many :votes

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, uniqueness: { case_sensitive: false }, length: { in: 2..20 },
                   format: { with: /\A[a-z]+([a-z0-9!@#$^]+[-_. ]?)*[a-z0-9!]+\z/i }, allow_nil: true
  validates :active, inclusion: { in: [true, false] }

  def name
    super || email.split('@', 2).first
  end

  def authorization
    JWT.encode({ email: email }, Rails.application.secret_key_base, 'HS256')
  end
end
