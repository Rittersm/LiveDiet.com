class HeightChangesToUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :height, :integer
    add_column :users, :feet, :integer
    add_column :users, :inches, :integer
  end
end
