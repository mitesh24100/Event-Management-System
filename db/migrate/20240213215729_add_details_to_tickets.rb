class AddDetailsToTickets < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :number_of_tickets, :integer
    add_column :tickets, :price, :integer
  end
end
