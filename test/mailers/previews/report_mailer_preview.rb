# frozen_string_literal: true

class ReportMailerPreview < ActionMailer::Preview
  # http://localhost:3000/rails/mailers/report_mailer/weekly_report
  def weekly_report
    subscriber = random_subscriber || Subscriber.create!(email: 'udotman3@gmail.com', name: 'Evgeny')

    report = Report.last
    if report.nil?
      ActiveRecord::Base.transaction do
        posts = Report::REQUIRED_WEEKDAYS.map do |day|
          image = random_image
          Post.create!(
            message: Message.active.where(darkness: [image&.darkness, nil]).sample,
            image:,
            created_at: Date.parse(day)
          )
        end
        report = Report.create!(posts:)
      end
    end

    ReportMailer.weekly_report(subscriber, report)
  end

  private

  def random_image
    Image.find_by(id: Image.active.pluck(:id).sample)
  end

  def random_subscriber
    Subscriber.find_by(id: Subscriber.active.pluck(:id).sample)
  end
end
