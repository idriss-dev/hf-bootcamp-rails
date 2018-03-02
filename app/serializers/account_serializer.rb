class AccountSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name

  #has_one :jwt
end
