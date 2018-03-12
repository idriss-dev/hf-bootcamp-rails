FactoryBot.define do
  factory :objective do
    name FFaker::Name.name
    description FFaker::Book::description
    due_date FFaker::Time::date
    status 'red'
    progress "9.99"
    milestones "MyString"
    priorities "MyString"

    account
    department
    association :assignees, factory: :account

    after :create do
      create_list :assignees, 3, objective: objective
    end
  end
end
