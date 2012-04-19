class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.text :comment
    	t.references :post
    	t.references :user
     	t.timestamps
    end
    add_index :comments, :post_id
    add_index :comments, :user_id
  end
end
