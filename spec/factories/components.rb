FactoryGirl.define do
  factory :component do
    sequence(:name) { |n| "myname#{n}" }
    link 'MyString'
    note 'MyText'
  end
end
