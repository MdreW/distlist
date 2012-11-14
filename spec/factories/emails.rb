FactoryGirl.define do
  factory :email do
    campaign
    subject "test email for {name}"
    body "Hi {name} {surname}, we talk about {lkey1} and {lkey2}"
#    sended false
  end
end
    
