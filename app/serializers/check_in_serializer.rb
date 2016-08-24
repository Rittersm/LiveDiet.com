class CheckInSerializer < ActiveModel::Serializer
  attributes :created_at, :weight, :new_bmi
end
