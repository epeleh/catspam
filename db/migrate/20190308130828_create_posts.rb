# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.belongs_to :image, null: false
      t.belongs_to :message
      t.belongs_to :report
      t.timestamps
    end
  end
end
