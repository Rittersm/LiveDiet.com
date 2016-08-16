class AddPlanReferenceToCheckin < ActiveRecord::Migration[5.0]
  def change
    add_reference :check_ins, :plan, index: true
  end
end
