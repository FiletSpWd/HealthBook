class CreateMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :marks do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.integer :rating

      t.timestamps
    end
  end
end
