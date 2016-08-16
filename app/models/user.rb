class User < ApplicationRecord
  has_secure_password
  has_many :plans
  has_many :subscriptions
  has_many :logs
  has_many :check_ins

  validates :username, presence: true, uniqueness: true, format: {:with => /\A[a-zA-Z0-9\-_]+\z/}
  validates :email, presence: true, uniqueness: true, format: {:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/}
  validates :feet, presence: true
  validates :starting_weight, presence: true

  def kg
    starting_weight/2.2046
  end

  def meters
    ((feet * 12) + inches) * 0.025
  end

  def starting_bmi
    (kg/meters ** 2).round(2)
  end

  def current_plan
    subscriptions.last.plan
  end

end
