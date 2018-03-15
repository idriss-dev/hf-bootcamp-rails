class Organization < ApplicationRecord
  belongs_to :account

  validates_presence_of :name
end
