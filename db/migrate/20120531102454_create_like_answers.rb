class CreateLikeAnswers < ActiveRecord::Migration
  def change
    create_table :like_answers do |t|
      t.references :answer
      t.references :user
      t.timestamps
    end
    add_index :like_answers, :answer_id
    add_index :like_answers, :user_id
  end
end
