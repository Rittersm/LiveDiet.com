class Plan < ApplicationRecord
  belongs_to :user, optional: true
  has_many :subscriptions
  has_many :logs
  has_many :check_ins

  def rating
    (subscriptions.sum(:rating))/subscriptions.count
  end

end
