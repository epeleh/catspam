# frozen_string_literal: true

class InviteController < ApplicationController
  def index
    subscriber = Subscriber.new(email: 'SUBSCRIBER_EMAIL', name: 'SUBSCRIBER_NAME')
    @mail_templates = [
      InviteMailer.invite(subscriber),
      InviteMailer.invite(subscriber, @current_user, 1),
      InviteMailer.invite(subscriber, @current_user, 2),
      InviteMailer.invite(subscriber, @current_user, 3),
      InviteMailer.invite(subscriber, @current_user, 4)
    ].map! { |x| x.body.encoded[/<body.*>([\s\S]*)<\/body>/i, 1].strip!.html_safe }
  end
end
