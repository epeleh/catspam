# frozen_string_literal: true

class PostsSendJob < ApplicationJob
  queue_as :default

  WAITING = { wait_until: 1.day.from_now.beginning_of_day.utc + 16.hours + rand(0...800).minutes }
  after_perform { self.class.set(WAITING).perform_later }

  def perform
    return if [0, 6].include?(Time.now.utc.wday)
    Post.create(image: Image.active.where(darkness: current_darkness).sample)
  end

  private

  def current_darkness
    case Time.now.utc.hour + 6
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
end
