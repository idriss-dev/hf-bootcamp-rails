class Objective < ApplicationRecord
  resourcify
  belongs_to :account
  belongs_to :department
  has_many :childs, :class_name => "Objective", foreign_key: "objective_id"
  belongs_to :parent, :class_name => "Objective", foreign_key: "objective_id", required: false
  #has_and_belongs_to_many :assignees, class_name: "Account", foreign_key: "account_id"

  serialize :milestones, Array

  validates_presence_of     :name
  validates_presence_of     :description
  validates_presence_of     :due_date
  validates_presence_of     :status
  validates_presence_of     :account
  validates_presence_of     :priorities
  validates_presence_of     :progress

  enum status: [:red, :orange, :green]
  enum priorities: [:p1, :p2, :p3, :p4, :p5]
end
