class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.integer :darkness, null: false
      t.boolean :active, null: false, default: true
      t.timestamps
    end
  end
end
