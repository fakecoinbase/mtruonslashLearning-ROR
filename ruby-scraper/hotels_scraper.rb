require 'nokogiri'
require 'open-uri'

module Scraper
  def scrape
    raise "Not implemented"
  end
end

class HotelsScraper
  include Scraper

  attr_accessor :doc
  @@user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36"

  def initialize(url)
    # Static page for exercise
    begin
      html = open(url, "User-Agent" => @@user_agent)
    rescue OpenURI::HTTPError => error
      response = error.io
      puts "Received: #{response.status}, failed to proceed with opening the URL"
      return response
    end
    @doc = Nokogiri::HTML(html)
    puts "Searching: #{url}"
  end

  def scrape
    results = []
    prices.each do |price|
      puts price.text
    end
   
    # Return populated tuple list (thread_title, vote_score)  
    return results
  end

  private
    def prices
      # div#book-info-container grabs the div w/ the following id
      @doc.css('div#book-info-container').css('.current-price')
    end
end

# Running the scraper for tests
product_url = "https://ca.hotels.com/ho378494/?q-check-out=2020-06-08&FPQ=2&q-check-in=2020-05-29&WOE=1&WOD=5&q-room-0-children=0&pa=1&tab=description&JHR=7&q-room-0-adults=2&YGF=14&MGT=7&ZSX=1&SYE=3"
scraper = HotelsScraper.new(product_url)
scraper.scrape
