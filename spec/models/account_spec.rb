require 'spec_helper'

describe Account do
  before { @account = FactoryBot.build(:account) }

  it "has a valid factory" do
    expect(build(:account)).to be_valid
  end

  subject { @account }

  it { should respond_to(:is_admin) }
  it { should respond_to(:full_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:is_invited) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:full_name) }

  it { should validate_uniqueness_of(:email) }

  it { should validate_length_of(:password).is_at_most(72) }
  it { should validate_length_of(:password).is_at_least(8) }

  it { should validate_confirmation_of(:password) }

  it { should allow_value('example@domain.com').for(:email) }
  it { should_not allow_value('example domain').for(:email) }

  it { should_not allow_value(nil).for(:is_admin) }
  it { should_not allow_value(nil).for(:is_invited) }

  it { should_not callback(:set_user).before(:validation).unless(:is_invited?) }
  it { should_not callback(:send_user_invitation).after(:validation).unless(:is_invited?) }

  it { should be_valid }
end
