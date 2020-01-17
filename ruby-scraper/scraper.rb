require 'nokogiri'
require 'open-uri'

module HTMLScraper
  include OpenURI
  include Nokogiri

  User_Agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36"

  def HTMLScraper.scrape(prices)
    if prices.first.nil?
      return 0.0
    else
      # Applies a regular expression for a price format dd.dd and converts it to a float 
      return prices.first.text[/\d+(\.)*\d+/].to_f
    end
  end

  class Scraper
    include HTMLScraper

    attr_accessor :doc
    attr_accessor :url

    def initialize(url)
      @url = url
      
      begin
        html = open(url, {"User-Agent" => HTMLScraper::User_Agent})
      rescue OpenURI::HTTPError => error
        response = error.io
        puts "Received #{response.status}. Failed to proceed with provided URL"
        return response
      end
      @doc = Nokogiri::HTML(html)
    end
  end

  # Amazon HTML Price Scraper class
  class AmazonScraper < Scraper
    def scrape_price
      HTMLScraper.scape(prices)
    end

    private
      def prices
        @doc.css('div#price').css('span#priceblock_ourprice')
      end
  end

  # Hotels.com HTML Price Scraper class
  class HotelsScraper < Scraper
    def scrape_price
      HTMLScraper.scrape(prices)
    end
    
    private
      def prices
        @doc.css('div#book-info-container').css('.current-price')
      end
  end
end

# Testing
product_url = "https://ca.hotels.com/ho355849/?q-check-out=2020-06-03&tab=description&q-room-0-adults=2&YGF=14&q-check-in=2020-06-01&MGT=2&WOE=3&WOD=1&ZSX=1&SYE=3&q-room-0-children=0"
scraper = HTMLScraper::HotelsScraper.new(product_url)
p scraper.scrape_price
