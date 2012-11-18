class Postman < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.postman.to_list.subject
  #
  def to_list(email, address)
    @address = address
    @email = email
    email.attachments.attached.each {|a| attachments[a.file_file_name] = File.read(a.file.path)}
    email.attachments.inline.each {|a| attachments.inline[a.file_file_name] = File.read(a.file.path)}

    mail(from: email.campaign.sender, to: address.recipient, subject: address.replace(email.subject))
  end
end
