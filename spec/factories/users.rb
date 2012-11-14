FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@distlist.it"}
    password '12345678'
    password_confirmation { |u| u.password }
  end
  factory :admin, :class => User do
    sequence(:email) { |n| "admin#{n}@distlist.it"}
    password '12345678'
    password_confirmation { |u| u.password }
    admin true
  end
end
