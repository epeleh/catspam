# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @reports = Report.includes(posts: { image: { file_attachment: :blob } })
    @solo_posts = Post.includes(image: { file_attachment: :blob }).active
                      .select { |x| x.created_at > (Report.maximum(:created_at) || 0) }
  end
end
