# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :option do
    address
    sequence(:key) {|n| "key#{n}"}
    sequence(:value) {|n| "value#{n}"}
  end
end
