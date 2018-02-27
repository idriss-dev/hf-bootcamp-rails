require "spec_helper"

RSpec.describe InviteUserMailer, type: :mailer do
  include Rails.application.routes.url_helpers

  describe ".send_confirmation" do
    before(:all) do
      @account = FactoryBot.create(:account)
      @invite_user_mailer = InviteUserMailer.send_user_invitation(@account)
    end

    it "should be set to be delivered to the user" do
      expect(@invite_user_mailer).to deliver_to(@account.email)
    end

    it "should be set to send from no-reply@email.com" do
      expect(@invite_user_mailer).to deliver_from("no-reply@email.com")
    end

    it "should have the correct subject" do
      expect(@invite_user_mailer).to have_subject(/Hi, #{@account.email} invited you to use javelo/)
    end
  end
end
