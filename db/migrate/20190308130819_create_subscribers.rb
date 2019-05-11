class CreateSubscribers < ActiveRecord::Migration[5.2]
  def change
    create_table :subscribers do |t|
      t.string :email, null: false
      t.string :name
      t.boolean :active, null: false, default: true
      t.timestamps
    end
  end
end
