# frozen_string_literal: true

class ReportMailer < ApplicationMailer
  def weekly_report(subscriber, report)
    @subscriber = subscriber
    @report = report

    mail(to: subscriber.email, subject: 'Weekly cats')
  end
end
