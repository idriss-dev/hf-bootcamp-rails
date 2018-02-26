FactoryBot.define do
  factory :admin do
    username FFaker::InternetSE.login_user_name
    account
  end
end
