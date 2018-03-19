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

  trait :tree do
    after(:create) do |objective|
      children = create_list :objective, 3
      children.each do |child|
        child.parent = objective
        child.save
      end
      new_parent = children.first
      children = create_list :objective, 5
      children.each do |child|
        child.parent = new_parent
        child.save
      end
    end
  end
end
