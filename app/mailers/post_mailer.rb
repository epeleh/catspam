# frozen_string_literal: true

class PostMailer < ApplicationMailer
  def daily_post(post, subscriber)
    @subscriber = subscriber
    @post = post

    mail(to: subscriber.email, subject: 'CAT!!!')
  end
end
