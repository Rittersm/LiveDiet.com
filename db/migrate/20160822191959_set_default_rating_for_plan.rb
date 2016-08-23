class SetDefaultRatingForPlan < ActiveRecord::Migration[5.0]
  def change
    change_column :plans, :rating, :decimal, default:  0.0
  end
end
