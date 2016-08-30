class Log < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  validates :daily_overview, presence: true
end
