class SubscriptionSerializer < ActiveModel::Serializer
  attributes :expectations, :start_weight, :start_bmi, :rating, :plan_id, :user_id

  belongs_to :user
end
