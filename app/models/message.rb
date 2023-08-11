# frozen_string_literal: true

class Message < ApplicationRecord
  has_one :post, dependent: :nullify

  scope :active, -> { where.not(id: Post.select(:message_id)) }
  scope :inactive, -> { where(id: Post.select(:message_id)) }

  validates :text, presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..80 }
  validates :darkness, inclusion: { in: 1..5 }, allow_nil: true

  def active?
    post.nil?
  end
end
