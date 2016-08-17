class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  before_save :set_starting_weight
  before_save :set_starting_bmi

  def starting_weight
    user.current_weight
  end

  def starting_bmi
    user.current_bmi
  end

  def set_starting_weight
    self.start_weight = starting_weight
  end

  def set_starting_bmi
    self.start_bmi = starting_bmi
  end

end
