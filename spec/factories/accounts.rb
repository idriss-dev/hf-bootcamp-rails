FactoryBot.define do
  factory :account do
    email { FFaker::Internet.email }
    password "12345678"
    password_confirmation "12345678"
    is_admin true
    full_name { FFaker::Name.name }
  end
end
