# frozen_string_literal: true

class Message < ApplicationRecord
  has_one :post

  scope :active, -> { where.not(id: Post.pluck(:message_id)) }
  scope :inactive, -> { where(id: Post.pluck(:message_id)) }

  validates :text, presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..80 }
  validates :darkness, inclusion: { in: 1..5 }, allow_nil: true

  def active?
    post.nil?
  end
end
