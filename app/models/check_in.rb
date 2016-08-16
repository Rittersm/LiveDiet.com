class CheckIn < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  def kg
    weight/2.2046
  end

  def new_bmi
    (kg/user.meters).round(2)
  end

end
