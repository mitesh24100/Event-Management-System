require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe Room, type: :model do
  let(:room) { FactoryBot.create(:room) }
  let(:user) { FactoryBot.create(:user)}


  describe "validations" do
    it "is valid with all required attributes" do
      expect(room).to be_valid
    end

    it "is invalid without a location" do
      room.location = nil
      expect(room).to_not be_valid
      expect(room.errors[:location]).to include("can't be blank")
    end

    it "is invalid without a capacity" do
      room.capacity = nil
      expect(room).to_not be_valid
      expect(room.errors[:capacity]).to include("can't be blank")
    end

    it "is invalid with a non-numeric capacity" do
      room.capacity = "abc"
      expect(room).to_not be_valid
      expect(room.errors[:capacity]).to include("is not a number")
    end

    it "is invalid with a capacity less than or equal to 0" do
      room.capacity = 0
      expect(room).to_not be_valid
      expect(room.errors[:capacity]).to include("must be greater than 0")

      room.capacity = -5
      expect(room).to_not be_valid
      expect(room.errors[:capacity]).to include("must be greater than 0")
    end
  end

  describe "associations" do
    it "has many events" do
      association = described_class.reflect_on_association(:events)
      expect(association.macro).to eq(:has_many)
    end
  end

end
