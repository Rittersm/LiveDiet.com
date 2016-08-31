class CheckIn < ApplicationRecord
  belongs_to :user
  belongs_to :subscription

  before_save :set_new_bmi

  validates :weight, presence: true
  validate :week_limit, on: :create

  def kg
    weight/2.2046
  end

  def set_new_bmi
    self.new_bmi = (kg/user.meters).round(2)
  end

  def week_limit
    if user.check_ins.any? && user.check_ins.last.created_at > 7.days.ago
      errors.add(:check_in, "cannot be posted more than once per week")
    end
  end

end
