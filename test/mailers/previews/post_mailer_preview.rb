# frozen_string_literal: true

class PostMailerPreview < ActionMailer::Preview
  # http://localhost:3000/rails/mailers/post_mailer/daily_post
  def daily_post
    subscriber = random_subscriber || Subscriber.create!(email: 'udotman3@gmail.com', name: 'Evgeny')
    post = Post.last
    if post.nil?
      image = random_image
      post = Post.create!(message: Message.active.where(darkness: [image&.darkness, nil]).sample, image: image)
    end

    PostMailer.daily_post(post, subscriber)
  end

  private

  def random_image
    Image.find_by_id(Image.active.pluck(:id).sample)
  end

  def random_subscriber
    Subscriber.find_by_id(Subscriber.active.pluck(:id).sample)
  end
end
