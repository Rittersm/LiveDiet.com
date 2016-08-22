class BmiAddedToCheckin < ActiveRecord::Migration[5.0]
  def change
    add_column :check_ins, :new_bmi, :decimal
  end
end
