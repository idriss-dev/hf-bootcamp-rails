class ObjectiveSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :due_date, :status, :progress, :milestones, :priorities
  has_one :account
  has_one :department
end
