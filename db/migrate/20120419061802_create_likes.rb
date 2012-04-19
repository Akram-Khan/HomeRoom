class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :post
      t.references :user
      t.timestamps
    end
    add_index :likes, :post_id
    add_index :likes, :user_id
  end
end
