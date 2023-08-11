# frozen_string_literal: true

class CreateSubscribers < ActiveRecord::Migration[5.2]
  def change
    create_table :subscribers do |t|
      t.string :email, null: false
      t.index 'lower(email)', unique: true

      t.string :name
      t.index 'lower(name)', unique: true

      t.boolean :active, null: false, default: true
      t.timestamps
    end
  end
end
