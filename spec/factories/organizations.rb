FactoryBot.define do
  factory :organization do
    name FFaker::Name.name
    account
  end
end
