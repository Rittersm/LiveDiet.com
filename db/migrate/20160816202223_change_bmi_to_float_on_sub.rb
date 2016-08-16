class ChangeBmiToFloatOnSub < ActiveRecord::Migration[5.0]
  def change
    change_column :subscriptions, :start_bmi, :decimal
    add_column :users, :start_bmi, :decimal
  end
end
