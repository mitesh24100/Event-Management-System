class AddKeysToTickets < ActiveRecord::Migration[7.1]
  def change
    add_reference :tickets, :user, null: false, foreign_key: true
    add_reference :tickets, :event, null: false, foreign_key: true
    add_reference :tickets, :room, null: false, foreign_key: true
  end
end
