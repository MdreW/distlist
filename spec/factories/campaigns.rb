FactoryGirl.define do
  factory :campaign do
    user
    title 'Campaign Test'
    header 'Header Test'
    footer 'Footer Test'
    sender_name 'name test'
    sender_email 'email_test@distlist.com'
  end
end
