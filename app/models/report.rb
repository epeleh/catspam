# frozen_string_literal: true

class Report < ApplicationRecord
  REQUIRED_WEEKDAYS = %w[Monday Tuesday Wednesday Thursday Friday].freeze

  has_many :posts, dependent: :nullify

  after_create :send_emails

  validate :validate_posts

  private

  def validate_posts
    errors.add(:posts, 'too much') if posts.size > 5
    errors.add(:posts, 'not enough') if posts.size < 5
    errors.add(:posts, 'bad weekdays') if (REQUIRED_WEEKDAYS - posts.map(&:weekday)).present?
    errors.add(:posts, 'already used') if Post.inactive.exists?(id: posts.select(&:id))
  end

  def send_emails
    Subscriber.active.each { |subscriber| ReportMailer.weekly_report(subscriber, self).deliver_later }
  end
end
