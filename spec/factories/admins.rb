FactoryBot.define do
  factory :admin do
    username FFaker::Name.name
    account
  end
end
