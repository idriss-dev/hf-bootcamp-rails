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
  end
end
