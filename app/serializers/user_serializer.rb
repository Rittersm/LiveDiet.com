class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :starting_weight, :feet, :inches, :start_bmi, :current_weight, :current_bmi

  has_many :logs
  has_many :check_ins

end
