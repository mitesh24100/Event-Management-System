class Ticket < ApplicationRecord
  belongs_to :event
  belongs_to :user
  belongs_to :purchased_for_user, class_name: 'User', optional: true
  validates :number_of_tickets, presence: true, numericality: { greater_than: 0 }
end
