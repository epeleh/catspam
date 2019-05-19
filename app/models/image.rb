# frozen_string_literal: true

class Image < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :file
  has_many :posts

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :used, -> { Image.joins(:posts).uniq }
  scope :not_used, -> { where.not(id: Image.used.pluck(:id)) }

  before_save :set_filename

  validates :file, attached: true, content_type: %w[image/png image/jpg image/jpeg].freeze
  validates :darkness, presence: true, inclusion: { in: 1..5 }
  validates :active, inclusion: { in: [true, false] }

  def filename
    file.filename
  end

  def url
    url_for(file) if file.attached?
  end

  def used?
    posts.present?
  end

  private

  def set_filename
    return unless file.attached?

    file_names = (ActiveStorageBlob.pluck(:filename) - [filename.to_s]).map { |name| File.basename(name, '.*') }
    file_names_max_length = file_names.map(&:length).max
    new_basename = file_names.select { |name| name.length == file_names_max_length }.max&.succ || 'A'

    file.blob.update(filename: "#{new_basename}.#{filename.extension}")
  end
end
