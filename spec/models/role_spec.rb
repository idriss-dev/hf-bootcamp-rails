require 'spec_helper'

RSpec.describe Role, type: :model do
  it { should allow_value(nil).for(:resource_type) }
  it { should validate_inclusion_of(:resource_type).in_array(Rolify.resource_types) }

  #it { should belong_to(:resource).optional }
end
