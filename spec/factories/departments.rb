FactoryBot.define do
  factory :department do
    name FFaker::Name.name
    account
    organization
  end
end
