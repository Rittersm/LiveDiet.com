class PlanSerializer < ActiveModel::Serializer
  attributes :title, :overview, :category

  has_many :subscriptions
end
