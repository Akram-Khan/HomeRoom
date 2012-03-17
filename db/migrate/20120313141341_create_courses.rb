class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :number
      t.string :name
      t.string :school
      t.string :term
      t.date :year
      t.string :invitation_code
      t.string :created_by
      t.timestamps
    end
  end
end
