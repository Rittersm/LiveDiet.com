class Plan < ApplicationRecord
  belongs_to :category
  has_many :subscriptions
  has_many :logs
  has_many :check_ins, through: :subscriptions

  def rating
    if subscriptions.any?
      (subscriptions.map(&:rating).compact.inject(0){|sum, x| sum + x.value}/subscriptions.count.to_f).round(2)
    else
      0
    end
  end

  def avg_start_weight
    if subscriptions.any?
      (subscriptions.all.inject(0){|sum, x| sum + x.start_weight}/subscriptions.count.to_f).round(0)
    else
      0
    end
  end


  def avg_change
    output = {}
    max_count = CheckIn.having(subscription_id: subscriptions.ids).group(:subscription_id).count.max_by{|key, value| value}[1]
    subscriptions.each do |y|
      max_count.times do |num|
        week = num + 1
        if y.check_ins.reverse[num]
          output["week#{week}".to_sym] = [] unless output["week#{week}".to_sym]
          output["week#{week}".to_sym] << y.check_ins.reverse[num].weight
        end
      end
    end
    output.each do |key, value|
      output[key] = output[key].inject(0){|sum, x| sum + x}/output[key].count
    end
    output
  end

end
