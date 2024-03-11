class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.string :feedback
      t.integer :rating

      t.timestamps
    end
  end
end
