class User < ApplicationRecord
  has_secure_password
  has_many :subscriptions, dependent: :destroy
  has_many :logs, dependent: :destroy
  has_many :check_ins, dependent: :destroy
  attachment :profile_image

  before_save :starting_bmi

  validates :username, presence: true, uniqueness: true, format: {:with => /\A[a-zA-Z0-9\-_]+\z/}
  validates :email, presence: true, uniqueness: true, format: {:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/}
  validates :feet, presence: true
  validates :inches, presence: true
  validates :starting_weight, presence: true

  def kg
    starting_weight/2.2046
  end

  def meters
    (((feet * 12) + inches) * 0.025) ** 2
  end

  def starting_bmi
    self.start_bmi = (kg/meters).round(2)
  end

  def current_subscription
    Subscription.where(user: self).last
  end

  def current_plan
    current_subscription&.plan
  end

  def current_weight
    if check_ins.any?
      check_ins.last.weight
    else
      starting_weight
    end
  end

  def current_bmi
    if check_ins.any?
      check_ins.last.new_bmi
    else
      start_bmi
    end
  end

end
