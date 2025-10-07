class CreateCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_items do |t|
      t.integer :user_id, null: false
      t.references :product_variant, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 1

      t.timestamps
    end

    add_foreign_key :cart_items, :users, column: :user_id, primary_key: :rut
  end
end
