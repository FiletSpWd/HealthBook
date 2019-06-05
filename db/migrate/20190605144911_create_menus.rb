class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.date :date_meal
      t.integer :weight

      t.timestamps
    end
  end
end
