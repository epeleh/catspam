# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'catspam@gmail.com'
  layout 'mailer'
end
