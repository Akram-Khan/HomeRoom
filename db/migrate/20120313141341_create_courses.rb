class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :number
      t.string :name
      t.string :school
      t.string :term
      t.date :year
      t.string :invitation_code_student
      t.string :invitation_code_teacher
      t.string :created_by
      t.boolean :active, :default => false
      t.timestamps
    end
  end
end
