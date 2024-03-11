class AddTotalpriceToTickets < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :total_price, :decimal
  end
end
