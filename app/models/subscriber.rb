# frozen_string_literal: true

class Subscriber < ApplicationRecord
  has_many :votes

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, uniqueness: true, format: { with: /\A[\w\s]*[a-z]+\z/i }, length: { in: 2..20 }, allow_nil: true
  validates :active, inclusion: { in: [true, false] }

  def authorization
    JWT.encode({ email: email }, Rails.application.secret_key_base, 'HS256')
  end
end
