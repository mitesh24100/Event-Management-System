FactoryBot.define do
  factory :ticket do
    user
    event
    number_of_tickets { 1 }
    total_price { 50.00 }
    # Add other necessary ticket attributes
  end
end