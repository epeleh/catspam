# frozen_string_literal: true

class WeeklyReportSendJob < ApplicationJob
  queue_as :default

  WAITING = { wait_until: (Date.parse('Sunday') + 1.week + 16.hours).utc }.freeze
  after_perform { self.class.set(WAITING).perform_later }

  def perform
    # TODO
  end
end
