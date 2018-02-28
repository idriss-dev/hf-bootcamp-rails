class InviteUserMailer < ApplicationMailer
  default from: "no-reply@email.com"

  def send_user_invitation(user)
    @user = user
    mail to: @user.email, subject: "Hi, #{@user.email} invited you to use javelo "
  end
end
