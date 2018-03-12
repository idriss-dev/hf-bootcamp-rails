require 'spec_helper'
RSpec.describe Objective, type: :model do

  before { @objective = FactoryBot.build(:objective) }

  it "has a valid objective factory" do
    expect(build(:objective)).to be_valid
  end

  subject { @objective }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:account) }
  it { should respond_to(:due_date) }
  it { should respond_to(:status) }
  it { should respond_to(:progress) }
  it { should respond_to(:milestones) }
  it { should respond_to(:priorities) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:account) }
  it { should validate_presence_of(:due_date) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:progress) }

  it { should define_enum_for(:status) }
  it { should allow_value(0).for(:status) }
  it { should allow_value(0).for(:status) }

  it { should have_db_column(:status).with_options(default: :red) }
  it { should have_db_column(:progress).with_options(default: 0.0) }

  it { should belong_to(:account) }
  it { should belong_to(:department) }

  it { should be_valid }

end
