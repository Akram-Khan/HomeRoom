class CreateInviteTeachers < ActiveRecord::Migration
  def change
    create_table :invite_teachers do |t|
      t.string :email
      t.string :firstname
      t.string :lastname
      t.integer :course_id
      t.integer :invited_by
      t.timestamps
    end
    add_index :invite_teachers, :email
    add_index :invite_teachers, :course_id
  end
end

