class Objective < ApplicationRecord
  belongs_to :account
  belongs_to :department
  has_and_belongs_to_many :assignees, class_name: "Account", foreign_key: "account_id"

  validates_presence_of     :name
  validates_presence_of     :description
  validates_presence_of     :due_date
  validates_presence_of     :status
  validates_presence_of     :account
  validates_presence_of     :progress

  enum status: [:red, :orange, :green]
end
