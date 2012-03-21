class CreateInviteStudents < ActiveRecord::Migration
  def change
    create_table :invite_students do |t|
      t.text :email
      t.integer :course_id
      t.timestamps
    end
    add_index :invite_students, :course_id
    #add_index :invite_students, :email
  end
end