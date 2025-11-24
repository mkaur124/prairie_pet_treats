# Clear existing products (optional)
Product.destroy_all

products = [
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

products.each do |prod|
  Product.create!(prod)
end

puts " 10 dog treat products added!"
