class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  def meters
    ((user.feet * 12) + user.inches) * 0.025
  end

  def kg
    starting_weight/2.2046
  end

  def starting_bmi
    (kg/meters ** 2).round(2)
  end

end
