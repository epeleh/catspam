# frozen_string_literal: true

class InviteMailer < ApplicationMailer
  def invite(subscriber, current_user = nil, type = nil)
    @subscriber = subscriber
    @current_user = current_user
    @type = current_user ? type.to_i : nil

    mail(to: subscriber.email, subject: 'Catspam invite')
  end
end
