# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @reports = Report.all
    @solo_posts = Post.active
  end
end
