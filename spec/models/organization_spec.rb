require 'spec_helper'

RSpec.describe Organization, type: :model do
  before { @organization = FactoryBot.build(:organization) }

  it "has a valid factory" do
    expect(build(:organization)).to be_valid
  end

  subject { @organization }

  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }

  it { should belong_to(:account) }
end
