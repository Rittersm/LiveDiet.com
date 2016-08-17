class SubscriptionSerializer < ActiveModel::Serializer
  attributes :expectations, :start_weight, :start_bmi, :rating

  belongs_to :user
end
