# frozen_string_literal: true

class PostMailer < ApplicationMailer
  def daily_post
    @post = params[:post]
    mail(to: params[:subscriber].email, subject: 'CAT!!!')
  end
end
