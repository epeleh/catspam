# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @reports = Report.all
    @solo_posts = Post.active.select { |x| x.created_at > (Report.pluck(:created_at).max || 0) }
  end
end
