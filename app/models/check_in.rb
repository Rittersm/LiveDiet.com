class CheckIn < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  def meters
    ((user.feet * 12) + user.inches) * 0.025
  end

  def kg
    weight/2.2046
  end

  def bmi
    (kg/meters ** 2).round(2)
  end

end
