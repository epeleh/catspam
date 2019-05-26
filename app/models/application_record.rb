# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :where_created_today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

  # noinspection RailsChecklist04
  def self.find_by_created_today
    find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end
end
