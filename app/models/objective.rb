class Objective < ApplicationRecord
  belongs_to :account
  belongs_to :department

  validates_presence_of     :name
  validates_presence_of     :description
  validates_presence_of     :due_date
  validates_presence_of     :status
  validates_presence_of     :progress
  validates_presence_of     :milestones
  validates_presence_of     :account
end
