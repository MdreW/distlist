# Read about factories at https://github.com/thoughtbot/factory_girl
include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :attachment do
    email
    atype 'attached'
    file { fixture_file_upload('spec/files/photo.jpg', 'image/jpeg') }
  end
end
