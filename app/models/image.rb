# frozen_string_literal: true

class Image < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :file
  has_one :post

  scope :active, -> { where.not(id: Post.pluck(:image_id)) }
  scope :inactive, -> { where(id: Post.pluck(:image_id)) }

  before_save :set_filename

  validates :file, attached: true, content_type: %w[image/png image/jpg image/jpeg].freeze
  validates :darkness, presence: true, inclusion: { in: 1..5 }

  def filename
    file.filename
  end

  def url
    url_for(file) if file.attached?
  end

  def active?
    post.nil?
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
