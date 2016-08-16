class AddRatingsToSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions, :rating, :integer
  end
end
