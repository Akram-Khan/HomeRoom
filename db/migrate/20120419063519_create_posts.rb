class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :type
      t.references :user
      t.references :course
      t.text :description	

      t.timestamps
    end
    add_index :posts, :course_id
    add_index :posts, :user_id
  end
end
