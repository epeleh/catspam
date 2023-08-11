# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :image
  belongs_to :message, optional: true
  belongs_to :report, optional: true, dependent: :destroy

  has_many :votes, dependent: :destroy

  scope :active, -> { includes(:report).where(report: nil) }
  scope :inactive, -> { joins(:report) }

  after_create :send_emails

  validate :validate_image
  validate :validate_message

  def stars
    votes.sum(:value)
  end

  def weekday
    created_at&.strftime('%A')
  end

  def active?
    report.nil?
  end

  private

  def validate_image
    errors.add(:image, 'already used') if image_id_changed? && Image.inactive.exists?(id: image&.id)
  end

  def validate_message
    errors.add(:message, 'already used') if message_id_changed? && Message.inactive.exists?(id: message&.id)
  end

  def send_emails
    Subscriber.active.each { |subscriber| PostMailer.daily_post(subscriber, self).deliver_later }
  end
end
