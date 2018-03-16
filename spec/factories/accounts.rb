FactoryBot.define do
  factory :account do
    email { FFaker::Internet.email }
    full_name { FFaker::Name.name }
    password "sekretstoff"
    password_confirmation "sekretstoff"

    trait :invited do
      invited = true
    end

    trait :admin do
      after(:create) {
        |account| account.add_role(:admin)
      }
    end

    trait :no_full_name do
      after(:build) {
        |account| account.full_name = ""
      }

      after(:create) {
        |account| account.full_name = ""
      }
    end
  end
end
