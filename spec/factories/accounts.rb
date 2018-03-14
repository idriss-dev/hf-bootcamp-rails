FactoryBot.define do
  factory :account do
    email { FFaker::Internet.email }
    full_name { FFaker::Name.name }

    trait :invited do
      invited = true
    end

    after(:create) do |account|
      password = FFaker:Internet.password
      account.password = password
      account.password_confirmation = password
    end
  end
end
