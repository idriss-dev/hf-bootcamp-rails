class Objective < ApplicationRecord
  belongs_to :account
  belongs_to :department

  validates_presence_of     :name
  validates_presence_of     :description
  validates_presence_of     :due_date
  validates_presence_of     :status
  validates_presence_of     :account
  validates_presence_of     :progress

  enum status: [:red, :orange, :green]
end
