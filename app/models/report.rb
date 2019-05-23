# frozen_string_literal: true

class Report < ApplicationRecord
  REQUIRED_WEEKDAYS = %w[Monday Tuesday Wednesday Thursday Friday].freeze

  has_many :posts

  after_create :send_emails

  validate :validate_posts

  private

  def validate_posts
    errors.add(:posts, 'too much') if posts.count > 5
    errors.add(:posts, 'not enough') if posts.count < 5
    errors.add(:posts, 'bad weekdays') if (REQUIRED_WEEKDAYS - posts.map(&:weekday)).present?
  end

  def send_emails
    Subscriber.active.each { |s| ReportMailer.weekly_report(self, s).deliver_later }
  end
end
