# frozen_string_literal: true

class InviteController < ApplicationController
  MAIL_TEMPLATES = [
    InviteMailer.invite(Subscriber.new(email: 'SUBSCRIBER_EMAIL', name: 'SUBSCRIBER_NAME')),
    InviteMailer.invite(Subscriber.new(email: 'SUBSCRIBER_EMAIL', name: 'SUBSCRIBER_NAME'), @current_user, 1),
    InviteMailer.invite(Subscriber.new(email: 'SUBSCRIBER_EMAIL', name: 'SUBSCRIBER_NAME'), @current_user, 2),
    InviteMailer.invite(Subscriber.new(email: 'SUBSCRIBER_EMAIL', name: 'SUBSCRIBER_NAME'), @current_user, 3),
    InviteMailer.invite(Subscriber.new(email: 'SUBSCRIBER_EMAIL', name: 'SUBSCRIBER_NAME'), @current_user, 4)
  ].map! do |x1|
    x1.body.encoded[%r{<body[\s\S]*?>([\s\S]*?)</body>}i, 1].strip!
      .tap { |x2| x2.gsub!(x2[/href=['"]([\s\S]*?)['"]/i, 1], '#') }.html_safe
  end.freeze

  def index
    @mail_templates = MAIL_TEMPLATES
  end
end
