class Plan < ApplicationRecord
  belongs_to :category
  has_many :subscriptions
  has_many :logs
  has_many :check_ins, through: :subscriptions

  validates :title, presence: true
  validates :overview, presence: true
  validates :category, presence: true

  default_scope { order(rating: :desc, sub_count: :desc) }

  def set_rating
    if subscriptions.any?
      self.rating = (subscriptions.reload.map(&:rating).compact.inject(0){|sum, x| sum + x.value}/subscriptions.count.to_f).round(2)
    end
  end

  def set_sub_count
    if subscriptions.any?
      self.sub_count = subscriptions.reload.count
    end
  end

  def avg_start_weight
    if subscriptions.any?
      (subscriptions.all.inject(0){|sum, x| sum + x.start_weight}/subscriptions.count.to_f).round(0)
    end
  end


  def avg_change(x)
    output = {}
    max_count = CheckIn.having(subscription_id: subscriptions.ids).group(:subscription_id).count.max_by{|key, value| value}[1]
    subscriptions.each do |y|
      max_count.times do |num|
        week = num + 1
        if y.check_ins.num
          output["week#{week}".to_sym] = [] unless output["week#{week}".to_sym]
          output["week#{week}".to_sym] << y.check_ins.num.send(x)
        end
      end
    end
    output.each do |key, value|
      output[key] = (output[key].inject(0){|sum, x| sum + x}/output[key].count).round(2)
    end
    output
  end

  def self.categorized_plans(title)
    Category.find_by(title: title).plans.all
  end

  def self.ranked_plans(title)
    categorized_plans(title).first
  end

  def is_subscribed(user)
    subscriptions.where(user: user).any?
  end

  def user_subscription(user)
    subscriptions.find_by(user: user)
  end

end
