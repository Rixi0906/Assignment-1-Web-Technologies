# --- Clean existing data to avoid duplication ---
OrderItem.destroy_all
Order.destroy_all
CartItem.destroy_all
ProductVariant.destroy_all
Product.destroy_all
Address.destroy_all
User.destroy_all

puts "Old records cleared!"

# --- Users ---
admin = User.create!(
  rut: 1,
  name: "Admin User",
  email: "admin@olive.com",
  password: "123456",
  role: "admin"
)

user1 = User.create!(
  rut: 2,
  name: "John Doe",
  email: "john@example.com",
  password: "123456",
  role: "customer"
)

user2 = User.create!(
  rut: 3,
  name: "Maria Gonzalez",
  email: "maria@example.com",
  password: "123456",
  role: "customer"
)

puts "Users created: #{User.count}"

# --- Addresses ---
Address.create!([
  { user: user1, name: "Home", address_line: "123 Olive St", city: "Santiago", region: "RM", postal_code: "8320000" },
  { user: user2, name: "Apartment", address_line: "456 Green Ave", city: "Valparaíso", region: "V", postal_code: "2340000" }
])

puts "Addresses created: #{Address.count}"

# --- Product ---
olive_oil = Product.create!(
  name: "Extra Virgin Olive Oil",
  description: "Premium cold-pressed olive oil produced in Chile. Ideal for salads, cooking, and tasting."
)

# --- Product Variants ---
variant_1l = ProductVariant.create!(
  product: olive_oil,
  size: "1L",
  price: 10.99,
  stock: 120
)

variant_5l = ProductVariant.create!(
  product: olive_oil,
  size: "5L",
  price: 45.99,
  stock: 50
)

puts "Product and variants created!"

# --- Cart Items ---
CartItem.create!([
  { user: user1, product_variant: variant_1l, quantity: 2 },
  { user: user2, product_variant: variant_5l, quantity: 1 }
])

puts "Cart items created: #{CartItem.count}"

# --- Orders ---
order1 = Order.create!(
  user: user1,
  address: user1.addresses.first,
  status: "paid",
  total: 21.98
)

order2 = Order.create!(
  user: user2,
  address: user2.addresses.first,
  status: "shipped",
  total: 45.99
)

puts "Orders created: #{Order.count}"

# --- Order Items ---
OrderItem.create!([
  { order: order1, product_variant: variant_1l, quantity: 2, unit_price: 10.99 },
  { order: order2, product_variant: variant_5l, quantity: 1, unit_price: 45.99 }
])

puts "Order items created: #{OrderItem.count}"

puts "Seed completed successfully!"
