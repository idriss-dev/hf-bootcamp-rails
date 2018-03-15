FactoryBot.define do
  factory :objective do
    name FFaker::Name.name
    description FFaker::Book::description
    due_date FFaker::Time::date
    status 'red'
    progress "9.99"
    milestones ["val", "val", "val"]
    priorities "p1"

    account
    department
  end
end
