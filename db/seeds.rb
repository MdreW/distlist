# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(:email => 'admin@distlist.com', :password => '12345678')
User.first.to_admin!
User.first.campaigns.create(:title => "example", :sender_name => "name", :sender_email => "example@mail.com", :time_gap => 0)
Campaign.first.addresses.create(:email => "example@mail.com", :name => "name", :surname => "surname", :options_attributes => [{:key => "key1", :value => "value1"}])
