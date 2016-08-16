class RemoveUserReferenceFromPlan < ActiveRecord::Migration[5.0]
  def change
    remove_reference :plans, :user, index: true
  end
end
