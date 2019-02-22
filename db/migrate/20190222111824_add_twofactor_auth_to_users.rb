class AddTwofactorAuthToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :persistence_token, :string
    add_column :users, :google_secret, :string
    add_column :users, :first_twofactor_logged_in, :boolean
  end
end
