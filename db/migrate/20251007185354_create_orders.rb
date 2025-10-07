class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false
      t.references :address, null: false, foreign_key: true
      t.string :status, null: false, default: "pending"
      t.decimal :total, precision: 10, scale: 2, null: false, default: 0.0

      t.timestamps
    end

    add_foreign_key :orders, :users, column: :user_id, primary_key: :rut
  end
end
