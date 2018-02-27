class Account < ApplicationRecord
  has_secure_password

  validates_length_of       :password, maximum: 72, minimum: 8, allow_nil: true, allow_blank: false
  validates_confirmation_of :password, allow_nil: true, allow_blank: false

  validates_presence_of     :email
  validates_presence_of     :full_name
  validates_uniqueness_of   :email

  validates_length_of :is_admin, allow_nil: false, allow_blank: false
end
