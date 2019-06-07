class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :avatar, :string, default: 'user.png'
    add_column :users, :sex, :string
    add_column :users, :activity, :string
    add_column :users, :growth, :float
    add_column :users, :weigth, :float
    add_column :users, :date_of_birth, :date
  end
end
