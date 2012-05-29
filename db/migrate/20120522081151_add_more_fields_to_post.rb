class AddMoreFieldsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :attached, :string
  end
end
