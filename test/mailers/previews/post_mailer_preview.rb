# frozen_string_literal: true

class PostMailerPreview < ActionMailer::Preview
  # http://localhost:3000/rails/mailers/post_mailer/daily_post
  def daily_post
    subscriber = random_subscriber || Subscriber.create(email: 'udotman3@gamil.com', name: 'Evgeny').tap(&:validate)
    post = Post.last || Post.create(message: 'Hello World!', image: random_image)
    PostMailer.daily_post(post, subscriber)
  end

  private

  def random_image
    Image.find(Image.pluck(:id).sample)
  end

  def random_subscriber
    Subscriber.find_by_id(Subscriber.pluck(:id).sample)
  end
end
