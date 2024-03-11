class Room < ApplicationRecord
  has_many :events, dependent: :destroy
  validates :location, presence: true
  validates :capacity, presence: true, numericality: { greater_than: 0 }
end
