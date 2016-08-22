class AddRatingColumnToPlan < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :rating, :decimal
  end
end
