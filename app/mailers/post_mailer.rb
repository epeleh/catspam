# frozen_string_literal: true

class PostMailer < ApplicationMailer
  def daily_post(post, subscriber)
    @subscriber = subscriber
    @post = post

    attachments.inline["cat.#{@post.image.filename.extension}"] = {
      mime_type: @post.image.file.blob.content_type,
      content: @post.image.file.blob.download
    }

    mail(to: subscriber.email, subject: 'Daily cat')
  end
end
