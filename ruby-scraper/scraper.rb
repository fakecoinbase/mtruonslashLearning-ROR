require 'nokogiri'
require 'open-uri'

$laptop_uri = 'https://www.amazon.ca/AmazonBasics-DSN-01750-SL-Laptop-Stand-Silver/dp/B00WRDS0AU/ref=sr_1_9?keywords=laptop+stand&qid=1576514518&sr=8-9'

class Scraper
  
  attr_accessor :doc

  def initialize
    # Static page for exercise
    doc = Nokogiri::HTML(open('https://www.amazon.ca/AmazonBasics-DSN-01750-SL-Laptop-Stand-Silver/dp/B00WRDS0AU/ref=sr_1_9?keywords=laptop+stand&qid=1576514518&sr=8-9'))

    self.get_price_wholes
  end

  def get_price_wholes
    doc.css(".priceBlockBuyingPriceString").each do |price|
      puts price.content
    end
  end
end

scraper = Scraper.new
puts "testing?"
