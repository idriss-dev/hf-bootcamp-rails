class Department < ApplicationRecord
  belongs_to :account
  belongs_to :organization

  validates_presence_of     :name
end
