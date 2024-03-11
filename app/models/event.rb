class Event < ApplicationRecord
  belongs_to(:room)
  has_many :tickets, dependent: :destroy
  has_many :reviews,dependent: :destroy
  validates :name, :category, :date, :start_time, :end_time, presence: true
  validates :ticket_price, numericality: { greater_than_or_equal_to: 0 }
  validate :validate_seats

  private

  def validate_seats
    if room.capacity < seats_left
      errors.add(:seats_left, "can't exceed the room's capacity")
    end
  end

end
