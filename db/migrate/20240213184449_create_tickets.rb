class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :confirmation_number

      t.timestamps
    end
  end
end
