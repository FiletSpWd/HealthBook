class AddWeightToCompositions < ActiveRecord::Migration[5.2]
  def change
    add_column :compositions, :weight, :integer
  end
end
