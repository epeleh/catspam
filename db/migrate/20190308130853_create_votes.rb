# frozen_string_literal: true

class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.belongs_to :subscriber, null: false
      t.belongs_to :post, null: false
      t.index %i[post_id subscriber_id], unique: true

      t.integer :value, null: false
      t.timestamps
    end
  end
end
