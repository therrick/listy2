FactoryGirl.define do
  factory :meal do
    association :component
    association :calendar
  end
end
