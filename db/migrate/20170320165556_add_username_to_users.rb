class AddUsernameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string, null: false, default: ""
    remove_column :users, :email
  end
end
