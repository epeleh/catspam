# frozen_string_literal: true

class ReportMailerPreview < ActionMailer::Preview
  # http://localhost:3000/rails/mailers/report_mailer/weekly_report
  def weekly_report
    subscriber = random_subscriber || Subscriber.create!(email: 'udotman3@gmail.com', name: 'Evgeny')

    report = Report.last
    if report.nil?
      posts = Report::REQUIRED_WEEKDAYS.map do |day|
        Post.new(message: "#{day} post by ReportMailerPreview", image: random_image, created_at: Date.parse(day))
      end
      report = Report.create!(posts: posts)
    end

    ReportMailer.weekly_report(report, subscriber)
  end

  private

  def random_image
    Image.find_by_id(Image.active.pluck(:id).sample)
  end

  def random_subscriber
    Subscriber.find_by_id(Subscriber.active.pluck(:id).sample)
  end
end
