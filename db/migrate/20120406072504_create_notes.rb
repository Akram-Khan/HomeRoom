class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
    	t.text :note
    	t.integer :course_id
    	t.integer :user_id
      t.timestamps
    end
    add_index :notes, :course_id
    add_index :notes, :user_id
  end
end
