FactoryBot.define do
  factory :department do
    name FFaker::Name.name
    account
    organization

    trait :no_name do
      after(:build) {
        |department| department.name = ""
      }
    end
  end
end
