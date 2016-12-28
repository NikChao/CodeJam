class AddRememberDigestToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :password, :string
    add_column :users, :remember_digest, :string
  end
end
