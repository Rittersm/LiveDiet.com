class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  belongs_to :rating
  has_many :check_ins

  before_save :set_starting_weight
  before_save :set_starting_bmi
  after_save :plan_set_rating
  after_save :plan_sub_count

  validates :expectations, presence: true
  validates :plan, presence: true

  def plan_set_rating
    plan.set_rating
    plan.save!
  end

  def plan_sub_count
    plan.set_sub_count
    plan.save!
  end

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
