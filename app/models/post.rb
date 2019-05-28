# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :image
  belongs_to :message, optional: true
  belongs_to :report, optional: true

  has_many :votes

  scope :active, -> { includes(:report).where(report: nil) }
  scope :inactive, -> { joins(:report) }

  after_create :send_emails

  validate :validate_image
  validate :validate_message

  def stars
    votes.pluck(:value).sum
  end

  def weekday
    created_at&.strftime('%A')
  end

  def active?
    report.nil?
  end

  private

  def validate_image
    errors.add(:image, 'already used') if image_id_changed? && Image.inactive.find_by_id(image&.id).present?
  end

  def validate_message
    errors.add(:message, 'already used') if message_id_changed? && Message.inactive.find_by_id(message&.id).present?
  end

  def send_emails
    Subscriber.active.each { |s| PostMailer.daily_post(self, s).deliver_later }
  end
end
