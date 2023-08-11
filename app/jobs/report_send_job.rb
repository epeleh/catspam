# frozen_string_literal: true

class ReportSendJob < ApplicationJob
  queue_as :default

  after_perform { self.class.set(self.class.waiting).perform_later }

  def self.waiting
    time = Time.zone.now

    if time.wday == Date.parse('Sunday').wday && !Report.exists?(created_at: Time.zone.now.all_day)
      return { wait: 30.seconds } if time.hour >= 16
      return { wait_until: time.beginning_of_day + 16.hours }
    end

    { wait_until: Date.parse('Sunday') + 1.week + 16.hours }
  end

  # Every Sunday at 22:00 (10pm) +0600 (Omsk)
  def perform
    last_monday = Date.parse('Monday') - 1.week
    last_friday = Date.parse('Friday') - 1.week
    Report.create(posts: Post.where(created_at: last_monday.beginning_of_day...last_friday.end_of_day))
  end
end
