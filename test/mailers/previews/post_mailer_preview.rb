# frozen_string_literal: true

class PostMailerPreview < ActionMailer::Preview
  def daily_post
    subscriber = Subscriber.new(email: 'udotman3@gamil.com', name: 'Evgeniy')
    post = Post.new(message: 'Hello World!', image: random_image)
    PostMailer.daily_post(post, subscriber)
  end

  private

  def random_image
    Image.find(Image.pluck(:id).shuffle.first)
  end
end
