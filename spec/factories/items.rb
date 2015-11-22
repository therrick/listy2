FactoryGirl.define do
  factory :item do
    association :store
    aisle nil
    name 'MyString'
    notes 'MyString'
    number_needed 1
    popularity 1
  end
end
