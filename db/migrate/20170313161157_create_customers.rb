class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :customer_id
      t.string :name
      t.float :long
      t.float :lat
      t.string :zone_name
      t.string :salesman_name
      t.integer :status
      t.date :last_visited_at
      t.date :last_invoice_at
      t.float :last_trx_amount
      t.string :extra1
      t.string :extra2
      t.string :extra3

      t.timestamps
    end
  end
end
