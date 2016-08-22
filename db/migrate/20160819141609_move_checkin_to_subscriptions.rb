class MoveCheckinToSubscriptions < ActiveRecord::Migration[5.0]
  def change
    remove_reference :check_ins, :plan, index: true
    add_reference :check_ins, :subscription, index: true
  end
end
