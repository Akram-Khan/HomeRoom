class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.text :comment
    	t.references :note
    	t.references :user
     	t.timestamps
    end
    add_index :comments, :note_id
    add_index :comments, :user_id
  end
end
