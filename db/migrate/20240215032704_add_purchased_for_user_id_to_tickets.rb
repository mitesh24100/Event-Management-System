class AddPurchasedForUserIdToTickets < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :purchased_for_user_id, :integer
    add_index :tickets, :purchased_for_user_id
  end
end
