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


    def initialize(url)
      self.url = url
    end

    attr_reader :url
    def url=(str)
      @url = str
      # Opening a new document for scraping
      begin
        html = open(url, {"User-Agent" => HTMLScraper::User_Agent})
      rescue OpenURI::HTTPError => error
        response = error.io
        puts "Received #{response.status}. Failed to proceed with provided URL"
        return response
      end
      @doc = Nokogiri::HTML(html)
    end

    def doc=(html)
      @doc = html
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

# Initializing Scraper
product_url = "https://ca.hotels.com/ho355849/?q-check-out=2020-06-03&tab=description&q-room-0-adults=2&YGF=14&q-check-in=2020-06-01&MGT=2&WOE=3&WOD=1&ZSX=1&SYE=3&q-room-0-children=0"
scraper = HTMLScraper::HotelsScraper.new(product_url)

# Outputting original content
p "Scraping hotel 1"
p "URL: #{scraper.url}"
p scraper.scrape_price

# Changing scraper url and updating doc

p "Scraping hotel 2"
scraper.url = "https://ca.hotels.com/ho116523/?intlid=TP+Hotel+2+Homepage+%3A%3A+TP+Properties&q-check-in=2020-06-01&q-check-out=2020-06-03&q-room-0-adults=2&q-room-0-children=0&q-rooms=1"
p "URL: #{scraper.url}"
p scraper.scrape_price
