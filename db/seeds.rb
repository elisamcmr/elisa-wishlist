# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
puts "Cleaning database..."
Bookmark.destroy_all
Item.destroy_all
List.destroy_all

# Create Lists
puts "Creating lists..."
birthday = List.create!(
  name: "Birthday Wishlist",
  description: "Things I'd love to get for my birthday"
)

christmas = List.create!(
  name: "Christmas Wishlist",
  description: "Perfect gifts for the holiday season"
)

home = List.create!(
  name: "Home Decor",
  description: "Items to make the house more cozy"
)

# Create Items with Bookmarks
puts "Creating items..."

# Birthday items
watch = Item.new(
  name: "Vintage Watch",
  description: "Beautiful analog watch with leather strap",
  price: 199.99,
  url: "https://www.example.com/vintage-watch"
)
watch.save!
Bookmark.create!(item: watch, list: birthday)

headphones = Item.new(
  name: "Noise-Cancelling Headphones",
  description: "Premium wireless headphones",
  price: 299.99,
  url: "https://www.example.com/headphones"
)
headphones.save!
Bookmark.create!(item: headphones, list: birthday)

# Christmas items
book = Item.new(
  name: "Coffee Table Book",
  description: "Photography book about nature",
  price: 45.00,
  url: "https://www.example.com/photo-book"
)
book.save!
Bookmark.create!(item: book, list: christmas)

sweater = Item.new(
  name: "Cashmere Sweater",
  description: "Soft winter sweater in navy blue",
  price: 150.00,
  url: "https://www.example.com/sweater"
)
sweater.save!
Bookmark.create!(item: sweater, list: christmas)

# Home items
lamp = Item.new(
  name: "Designer Floor Lamp",
  description: "Modern standing lamp with adjustable brightness",
  price: 249.99,
  url: "https://www.example.com/floor-lamp"
)
lamp.save!
Bookmark.create!(item: lamp, list: home)

vase = Item.new(
  name: "Ceramic Vase",
  description: "Handmade ceramic vase in earth tones",
  price: 79.99,
  url: "https://www.example.com/vase"
)
vase.save!
Bookmark.create!(item: vase, list: home)

puts "Created #{List.count} lists"
puts "Created #{Item.count} items"
puts "Created #{Bookmark.count} bookmarks"
puts "Seeding completed!"

# Add some items to multiple lists
puts "Adding items to multiple lists..."

# Add the watch to Christmas list too
Bookmark.create!(item: watch, list: christmas)

# Add the headphones to Home list
Bookmark.create!(item: headphones, list: home)

puts "Added cross-list items"
