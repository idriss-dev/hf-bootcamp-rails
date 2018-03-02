FactoryBot.define do
  factory :objective do
    name FFaker::Name.name
    description FFaker::Book::description
    due_date FFaker::Time::date
    status 1
    progress "9.99"
    milestones "MyString"
    priorities "MyString"

    account
    department

    trait :missing_name do
      after(:create) do |instance|
        instance.delete(name)
      end
    end

    trait :missing_account do
      after(:create) do |instance|
        instance.delete(account)
      end
    end

    trait :missing_department do
      after(:create) do |instance|
        instance.delete(account)
      end
    end
  end
end
