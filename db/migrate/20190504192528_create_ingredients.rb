class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :title
      t.string :category
      t.float :protein
      t.float :fat
      t.float :sugar
      t.float :calories

      t.timestamps
    end
  end
end
