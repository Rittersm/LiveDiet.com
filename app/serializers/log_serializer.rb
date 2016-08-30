class LogSerializer < ActiveModel::Serializer
  attributes :daily_overview, :user_id, :created_at
end
