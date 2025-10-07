class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :address_line, null: false
      t.string :city, null: false
      t.string :region, null: false
      t.string :postal_code, null: false

      t.timestamps
    end

    add_foreign_key :addresses, :users, column: :user_id, primary_key: :rut
  end
end
