require 'spec_helper'
RSpec.describe Admin, type: :model do
  before { @admin = FactoryBot.build(:admin) }

  it "has a valid factory" do
    expect(build(:admin)).to be_valid
  end

  subject { @admin }

  it { should respond_to(:username) }

  it { should has_one(:account) }

  it { should be_valid }
end
