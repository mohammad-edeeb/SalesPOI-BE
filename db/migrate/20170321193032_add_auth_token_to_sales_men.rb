class AddAuthTokenToSalesMen < ActiveRecord::Migration[5.0]
  def change
    add_column :sales_men, :auth_token, :string
    add_index :sales_men, :auth_token, unique: true
  end
end
