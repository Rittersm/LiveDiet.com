class CheckIn < ApplicationRecord
  belongs_to :user
  belongs_to :subscription

  before_save :set_new_bmi

  def kg
    weight/2.2046
  end

  def set_new_bmi
    self.new_bmi = (kg/user.meters).round(2)
  end

end
