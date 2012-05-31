class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :description
      t.boolean :correct, :default => false
      t.references :user
      t.references :course
      t.references :post
      t.timestamps
    end
    add_index :answers, :course_id
    add_index :answers, :user_id
    add_index :answers, :post_id   
  end
end
