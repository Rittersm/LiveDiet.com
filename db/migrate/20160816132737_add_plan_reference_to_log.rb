class AddPlanReferenceToLog < ActiveRecord::Migration[5.0]
  def change
    add_reference :logs, :plan, index: true
  end
end
