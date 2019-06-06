class CreateDiets < ActiveRecord::Migration[5.2]
  def change
    create_table :diets do |t|
      t.string :title
      t.string :description
      t.string :cover

      t.timestamps
    end
  end
end
