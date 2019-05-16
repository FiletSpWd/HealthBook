class AddCategoryToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :category_id, :int
  end
end
