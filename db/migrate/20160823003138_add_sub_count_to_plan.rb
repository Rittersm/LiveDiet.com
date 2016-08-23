class AddSubCountToPlan < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :sub_count, :integer, default: 0
  end
end
