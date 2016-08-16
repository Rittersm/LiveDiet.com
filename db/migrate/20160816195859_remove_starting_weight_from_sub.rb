class RemoveStartingWeightFromSub < ActiveRecord::Migration[5.0]
  def change
    remove_column :subscriptions, :starting_weight, :integer
  end
end
