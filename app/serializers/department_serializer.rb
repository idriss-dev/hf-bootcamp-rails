class DepartmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :organization_id, :account_id
end
