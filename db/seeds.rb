# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(:email => 'admin@distlist.com', :password => '12345678')
User.first.to_admin!
User.create(:email => 'user@distlist.com', :password => '12345678')
User.first.campaigns.create(:title => "Example campaign", :sender_name => "name", :sender_email => "example@distlist.com", :header => "<p>A common header for each email</p>", :footer => "</p>A common footer for each email</p>", :time_gap => 0, :unsubscribe => true)
Campaign.first.addresses.create(:email => "user1@distlist.com", :name => "user1", :surname => "surname1", :options_attributes => [{:key => "key1", :value => "value1"}, {:key => "key2", :value => "value2"}])
Campaign.first.addresses.create(:email => "user2@distlist.com", :name => "user2", :surname => "surname2", :options_attributes => [{:key => "key1", :value => "value1"}, {:key => "key2", :value => "value2"}])
Campaign.first.addresses.create(:email => "user3@distlist.com", :name => "user3", :surname => "surname3", :options_attributes => [{:key => "key1", :value => "value1"}, {:key => "key2", :value => "value2"}])
Campaign.first.addresses.create(:email => "user4@distlist.com", :name => "user4", :surname => "surname4", :options_attributes => [{:key => "key1", :value => "value1"}, {:key => "key2", :value => "value2"}])
Campaign.first.addresses.create(:email => "user5@distlist.com", :name => "user5", :surname => "surname5", :options_attributes => [{:key => "key1", :value => "value1"}, {:key => "key2", :value => "value2"}])
Campaign.first.addresses.create(:email => "user6@distlist.com", :name => "user6", :surname => "surname6", :options_attributes => [{:key => "key1", :value => "value1"}, {:key => "key2", :value => "value2"}])
Campaign.first.emails.create(:subject => "News for you Mr. {name} {surname}!", :body => "<p><b>The text replacement work correctly!</b></p><ul><li>Key1 is {key1}</li><li>Key2 is {key2}</li></ul>")
Campaign.first.emails.create(:subject => "Other example... {name} {key}", :body => "<p>Bye bye {surname}</p>", :key_required => "key1 key2")
Campaign.first.emails.create(:subject => "Last example bla bla", :body => "<h2>Stress Test!</h2><p><!{{{name}/{surname@}\{key}}</p>", :key_required => "inexistent_key")
