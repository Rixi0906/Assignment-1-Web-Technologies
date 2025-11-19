# db/migrate/20251119004813_add_devise_to_users.rb
class AddDeviseToUsers < ActiveRecord::Migration[8.0]
  def change
    change_table :users do |t|
      ## Database authenticatable
      # We ALREADY have :email, so DO NOT add it again.
      # t.string :email,              null: false, default: ""

      # Devise needs this:
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      # If later you add :confirmable, :lockable, etc., their columns go here.
    end

    # We ALREADY have an index on :email in your schema, so don't add another.
    # add_index :users, :email, unique: true

    add_index :users, :reset_password_token, unique: true
  end
end
