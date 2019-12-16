require 'HTTParty'
require 'Nokogiri'

class Scraper
  
  attr_accessor :parse_page

  def initialize
    # Static page for exercise
    doc = HTTParty.get("https://www.amazon.ca/s?k=laptop+stand&ref=nb_sb_noss_2")
    # Creating an instance variable of the Nokogiri HTML data object
    @parse_page ||= Nokogiri::HTML(doc)
  end

  def get_price_wholes
    price_wholes = parse_page.css("a-price").css("a-price-whole").children.map { |price_whole| price_whole.text }.compact
  end

  scraper = Scraper.new
  price_wholes = scraper.get_price_wholes

  (0...price_wholes.size).each do |index|
    puts "- - - index: #{index + 1} - - -"
    puts "Price Whole = $#{price_wholes[index]}"
  end
end
