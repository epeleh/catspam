# frozen_string_literal: true

class PostsSendJob < ApplicationJob
  queue_as :default

  after_perform { self.class.set(self.class.waiting).perform_later }

  def self.waiting
    time = Time.zone.now

    return skip_days(2) if time.wday == Date.parse('Saturday').wday
    return skip_days(1) if time.wday == Date.parse('Sunday').wday

    if Post.find_by_created_today.nil?
      return skip_days(0) if time.hour < 4
      return { wait: 30.seconds } if time.hour >= 14
      return { wait_until: time.beginning_of_day + 4.hours + rand(((time.hour - 4) * 60 + time.min)...600).minutes }
    end

    return skip_days(3) if time.wday == Date.parse('Friday').wday

    skip_days(1)
  end

  # Every weekday (Mon, Tue, Wed, Thu, Fri) between 10:00 (10am) and 20:00 (8pm) +0600 (Omsk)
  def perform
    # TODO: associate "random" message here
    Post.create(image: Image.active.where(darkness: current_darkness).sample)
  end

  private

  def current_darkness
    case Time.zone.now.hour + 6
    when 10...12
      1
    when 12...14
      2
    when 14...16
      3
    when 16...18
      4
    when 18...20
      5
    else
      rand(1..5)
    end
  end

  def self.skip_days(days_n)
    { wait_until: days_n.day.from_now.beginning_of_day + 4.hours + rand(0...600).minutes }
  end

  private_class_method :skip_days
end
