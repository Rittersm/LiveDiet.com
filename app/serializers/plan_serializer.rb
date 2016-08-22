class PlanSerializer < ActiveModel::Serializer
  attributes :title, :overview, :category, :rating

  has_many :subscriptions, each_serializer: SubscriptionSerializer
end
