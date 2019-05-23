# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :report, optional: true
  belongs_to :image

  has_many :votes

  scope :active, -> { includes(:report).where(report: nil) }
  scope :inactive, -> { joins(:report) }

  after_save :inactivate_image
  after_create :send_emails

  validates :message, length: { in: 2..640 }, allow_nil: true

  def weekday
    created_at.strftime('%A')
  end

  def active?
    report.nil?
  end

  private

  def inactivate_image
    image.update(active: false)
  end

  def send_emails
    Subscriber.active.each { |s| PostMailer.daily_post(self, s).deliver_later }
  end
end
