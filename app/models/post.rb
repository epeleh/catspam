# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :image

  after_save :inactivate_image
  after_save :send_emails

  validates :message, length: { minimum: 2, maximum: 640 }, allow_blank: true

  private

  def inactivate_image
    image.update(active: false)
  end

  def send_emails
    Subscriber.active.each { |s| PostMailer.daily_post(self, s).deliver_later }
  end
end
