class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.belongs_to :image, null: false
      t.text :message
      t.timestamps
    end
  end
end
