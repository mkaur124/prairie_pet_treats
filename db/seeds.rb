# db/seeds.rb

require 'faker'

puts "Seeding database..."

provinces = [
  { name: "Alberta", gst: 5.0, pst: 0.0, hst: 0.0 },
  { name: "British Columbia", gst: 5.0, pst: 7.0, hst: 0.0 },
  { name: "Manitoba", gst: 5.0, pst: 7.0, hst: 0.0 },
  { name: "New Brunswick", gst: 0.0, pst: 0.0, hst: 15.0 },
  { name: "Newfoundland and Labrador", gst: 0.0, pst: 0.0, hst: 15.0 },
  { name: "Nova Scotia", gst: 0.0, pst: 0.0, hst: 15.0 },
  { name: "Ontario", gst: 0.0, pst: 0.0, hst: 13.0 },
  { name: "Prince Edward Island", gst: 0.0, pst: 0.0, hst: 15.0 },
  { name: "Quebec", gst: 5.0, pst: 9.975, hst: 0.0 },
  { name: "Saskatchewan", gst: 5.0, pst: 6.0, hst: 0.0 }
]

provinces.each do |province|
  Province.find_or_create_by!(province)
end

puts "Provinces seeded!"

# Clear existing products and reset SQLite autoincrement
Product.destroy_all
if ActiveRecord::Base.connection.adapter_name == "SQLite"
  ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='products'")
end

# Create default categories if they don't exist
categories = ["Beef", "Chicken", "Peanut Butter", "Variety Pack", "Treats", "Chews", "Snacks"].map do |name|
  Category.find_or_create_by!(name: name)
end

# Original 10 products
original_products = [
  { name: "Beef Jerky Treats", description: "100% natural beef jerky treats for dogs, protein-packed and delicious.", price: 12.99, stock_quantity: 50 },
  { name: "Chicken Bites", description: "Tender chicken bites made from all-natural ingredients. Perfect for training.", price: 10.49, stock_quantity: 40 },
  { name: "Peanut Butter Bones", description: "Crunchy bones filled with natural peanut butter. Dogs love them!", price: 8.99, stock_quantity: 60 },
  { name: "Small Variety Pack - Chicken & Beef", description: "A mix of chicken and beef treats, great for small dogs.", price: 15.99, stock_quantity: 30 },
  { name: "Peanut Butter Mini Bites", description: "Small bite-sized peanut butter treats for training or snacks.", price: 7.99, stock_quantity: 70 },
  { name: "Chicken Jerky Strips", description: "All-natural chicken strips, chewy and healthy for dogs of all sizes.", price: 11.49, stock_quantity: 45 },
  { name: "Beef & Peanut Butter Combo Pack", description: "A combo pack with beef jerky and peanut butter treats.", price: 18.99, stock_quantity: 25 },
  { name: "Assorted Treat Sampler", description: "Variety pack of all-natural dog treats: beef, chicken, and peanut butter.", price: 20.99, stock_quantity: 20 },
  { name: "Chicken & Cheese Bites", description: "Savory chicken bites with real cheese, a tasty reward for your dog.", price: 12.49, stock_quantity: 35 },
  { name: "Beef Mini Bones", description: "Small beef-flavored bones, perfect for small breeds or training.", price: 9.99, stock_quantity: 50 }
]

# Assign first few products to ensure each category has products
categories.each_with_index do |cat, index|
  prod = original_products[index % original_products.length]
  prod[:category] = cat
  Product.create!(prod)
end

# Create remaining products with Faker
(100 - categories.length).times do
  Product.create!(
    name: "#{Faker::Food.ingredient} Treat",
    description: Faker::Food.description,
    price: Faker::Commerce.price(range: 5.0..25.0),
    stock_quantity: rand(10..100),
    category: categories.sample
  )
end
categories.each do |cat|
  needed = 5 - cat.products.count
  if needed > 0
    needed.times do
      Product.create!(
        name: "#{Faker::Food.ingredient} Treat",
        description: Faker::Food.description,
        price: Faker::Commerce.price(range: 5.0..25.0),
        stock_quantity: rand(10..100),
        category: cat
      )
    end
  end
end

puts "100 dog treat products added with categories!"
