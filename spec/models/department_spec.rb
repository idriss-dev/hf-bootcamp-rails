require 'spec_helper'

describe Department do
  before { @department = FactoryBot.build(:department) }

  it "has a valid factory" do
    expect(build(:department)).to be_valid
  end

  subject { @department }

  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }

  it { should belong_to(:account) }
  it { should belong_to(:organization) }
end
