require 'nokogiri'
require 'open-uri'

# URL to scrape
url = "https://www.brindlepets.ca/collections/treats-and-chews"

# Open and parse the page
doc = URI.open(url)
page = Nokogiri::HTML(doc)

# Create default category
category = Category.find_or_create_by(name: "Treats")

# Iterate through each product item
page.css('.productgrid--item').each do |item|
  begin
    # Product name
    name = item.at_css('.productitem--title')&.text&.strip
    next unless name # skip if no name found

    # Price
    price = item.at_css('.price-item--regular')&.text&.gsub('$','')&.to_f || 0.0

    # Product URL to scrape description
    product_path = item.at_css('a.full-unstyled-link')['href']
    product_url = "https://www.brindlepets.ca#{product_path}"
    product_page = Nokogiri::HTML(URI.open(product_url))

    # Description
    description = product_page.at_css('.product-single__description')&.text&.strip || "No description"

    # Optional: Image URL
    image_url = product_page.at_css('.product-single__photo')&.[]('src')

    # Find or create product (prevents duplicates)
    product = Product.find_or_initialize_by(name: name)
    product.description = description
    product.price = price
    product.stock_quantity ||= rand(10..100)
    product.category = category

    if product.new_record?
      product.save!
      puts "Created new product: #{name}"
    else
      puts "Product already exists: #{name}"
    end

    # Optional: attach image if ActiveStorage is configured and image not attached
    if image_url.present? && !product.image.attached?
      file = URI.open(image_url)
      product.image.attach(io: file, filename: File.basename(image_url))
      puts "   Attached image for: #{name}"
    end

  rescue => e
    puts "Error scraping product '#{name}': #{e.message}"
  end
end

puts "Scraping completed!"
