require 'spec_helper'

RSpec.describe OrganizationPolicy do
  let(:organization) {
    FactoryBot.create :organization
  }

  subject { OrganizationPolicy.new(account, organization) }

  context "for a user" do
    let(:account) {
      FactoryBot.create :account
    }

    it { should_not permit :create }
    it { should_not permit :update }
    it { should_not permit :destroy }
  end

  context "for an admin" do
    let(:account) {
      FactoryBot.create :account, :admin
    }

    it { should permit :create }
    it { should permit :update }
    it { should permit :destroy }
  end
end
