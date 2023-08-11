# frozen_string_literal: true

class InviteMailerPreview < ActionMailer::Preview
  # http://localhost:3000/rails/mailers/invite_mailer/invite
  def invite
    subscriber = random_subscriber || Subscriber.create!(email: 'udotman3@gmail.com', name: 'Evgeny')
    current_user = random_subscriber
    type = (0..4).to_a.sample

    InviteMailer.invite(subscriber, current_user, type)
  end

  private

  def random_subscriber
    Subscriber.find_by(id: Subscriber.active.pluck(:id).sample)
  end
end
