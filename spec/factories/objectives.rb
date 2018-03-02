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
  end
end
