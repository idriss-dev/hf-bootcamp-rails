FactoryBot.define do
  factory :organization do
    name FFaker::Name.name
    account

    trait :no_name do
      after(:build) {
        |organization| organization.name = ""
      }
    end
  end
end
