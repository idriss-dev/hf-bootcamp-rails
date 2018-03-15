FactoryBot.define do
  factory :objective do
    sequence(:name) {|n| "objective#{n}" }
    description FFaker::Book::description
    due_date FFaker::Time::date
    status 'red'
    progress "9.99"
    milestones ["val", "val", "val"]
    priorities "p1"

    account
    department
  end

  trait :child do
    parent_id 1
  end
end
