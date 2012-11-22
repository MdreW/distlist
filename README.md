distlist
========

DistList - Simplified management of email communications

Distlist is a system for manage complex email.  Every address has many keys, usefull for replacement during the mail sending.

With "rake db:seed" the system save a user "admin@distlist.com" with password "12345678", with this users is possible generate a 
new use with a sensate password.

Before Distlist's use you must configure the system for sending mail. An example is present in development.rb

At this moment the graphics is strictly css3/html5 and not work correctly with iexplorer. In the next release I will work for  a more compatible template.

### Features
* Multiple campaign manager
* Email and address are limited for each campaign
* replacement text  based on the address for email before send
* Keys and values in each address for text replacement
* Tags for address definition
* send email for tagged user
* send email for specific key owner
* WYSIWYG Editor for email
* attachment management for email:
* - in line (as email text)
* - attached (attached in email)
* - off-lie (accessible in the site with link)
* Address unsubscription 
* Totally open source!

### To do:

* More report
* More pretty and compatible template
* Do not allow simultaneous deliveries of same email
* Do not allow modify or delete an email when send thread is active

### collaborate

* Fork me
* Send your code
* Tell me your ideas
* Join
* .....
