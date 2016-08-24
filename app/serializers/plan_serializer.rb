class PlanSerializer < ActiveModel::Serializer
  attributes :id, :title, :overview, :category, :rating

  has_many :subscriptions, each_serializer: SubscriptionSerializer
end
