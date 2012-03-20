class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.integer :course_id
      t.integer :user_id
      t.timestamps
    end
    add_index :roles, :name
    add_index :roles, :course_id
    add_index :roles, :user_id
  end
end
