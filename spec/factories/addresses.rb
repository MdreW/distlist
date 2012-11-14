FactoryGirl.define do
  factory :address do
    campaign
    sequence(:email) {|n| "address#{n}@distlist.it"}
    sequence(:name) {|n| "name#{n}"}
    sequence(:surname) {|n| "surname#{n}"}
#    fail_count 0
    options_attributes [{:key => "lkey1", :value => "value1"},{:key => "lkey2", :value => "value2"}]
  end
end
