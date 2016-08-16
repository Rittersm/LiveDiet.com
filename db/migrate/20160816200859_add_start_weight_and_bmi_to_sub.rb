class AddStartWeightAndBmiToSub < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions, :start_weight, :integer
    add_column :subscriptions, :start_bmi, :integer
  end
end
