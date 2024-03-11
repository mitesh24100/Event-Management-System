# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@gmail.com" }
    sequence(:name) { |n| "Test #{n}" }
    password { "test12345" }
    password_confirmation { "test12345" }
    address { "123 Test St, Testville" }
    credit_card_number { "1234 5678 9012 3456" }
    phone_number { "1234567890" }
    admin { false }
  end
end
