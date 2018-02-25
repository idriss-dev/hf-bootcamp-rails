class ObjectiveSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :due_date, :status, :progress, :milestones, :priorities
  has_one :assignee
  has_one :department
end
