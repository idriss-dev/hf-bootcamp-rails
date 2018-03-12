class Account < ApplicationRecord
  resourcify
  rolify
  has_secure_password

  validates_length_of       :password, maximum: 72, minimum: 8, allow_nil: true, allow_blank: false
  validates_confirmation_of :password, allow_nil: true, allow_blank: false

  validates_presence_of     :email
  validates_uniqueness_of   :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates_presence_of     :full_name

  validates_length_of   :is_admin, allow_nil: false, allow_blank: false
  validates_length_of   :is_invited, allow_nil: false, allow_blank: false

  before_validation :set_user, if: :is_invited?
  after_validation :send_user_invitation, if: :is_invited?

  has_and_belongs_to_many :objectives

  private

  def is_invited?
    is_invited
  end

  def set_user
    self.password = (0...8).map { (65 + rand(26)).chr }.join
    self.password_confirmation = self.password
    self.full_name = self.email
  end

  def send_user_invitation
    InviteUserMailer.send_user_invitation(self).deliver
  end
end
