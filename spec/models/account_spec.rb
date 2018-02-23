require 'spec_helper'

describe Account do
  before { @account = FactoryBot.build(:account) }
  it "has a valid factory" do
    expect(build(:factory_you_built)).to be_valid
  end

  subject { @account }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:password_confirmation) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should allow_value('example@domain.com').for(email) }

  it { should validate_confirmation_of(:password) }

  it { should be_valid }
end
