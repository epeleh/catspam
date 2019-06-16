# frozen_string_literal: true

class InviteController < ApplicationController
  SUBSCRIBER_TEMPLATE = Subscriber.new(email: '{{subscriber_email}}', name: '{{subscriber_name}}').freeze
  CURRENT_USER_TEMPLATE = Subscriber.new(email: '{{current_user_email}}', name: '{{current_user_name}}').freeze
  MAIL_TEMPLATES = [
    InviteMailer.invite(SUBSCRIBER_TEMPLATE),
    InviteMailer.invite(SUBSCRIBER_TEMPLATE, CURRENT_USER_TEMPLATE, 1),
    InviteMailer.invite(SUBSCRIBER_TEMPLATE, CURRENT_USER_TEMPLATE, 2),
    InviteMailer.invite(SUBSCRIBER_TEMPLATE, CURRENT_USER_TEMPLATE, 3),
    InviteMailer.invite(SUBSCRIBER_TEMPLATE, CURRENT_USER_TEMPLATE, 4)
  ].map! do |x1|
    x1.body.encoded[%r{<body[\s\S]*?>([\s\S]*?)</body>}i, 1].strip!
      .tap { |x2| x2.gsub!(/\s*href=['"]([\s\S]*?)['"]/i, '') }
      .tap { |x3| x3.gsub!(/{{(\w+)}}/i, '<span id="\1"></span>') }.html_safe
  end.freeze

  def index
    @mail_templates = MAIL_TEMPLATES
  end
end
