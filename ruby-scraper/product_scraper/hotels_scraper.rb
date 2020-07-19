require_relative 'scraper'

module ProductScraper
  class HotelsScraper < Scraper
    def scrape
      html_scrape_for(prices)
    end

    private
      def prices
        @doc.css('div#book-info-container').css('.current-price')
      end
  end
end

# Testing
p "Testing the Product Scraper"
s = ProductScraper::HotelsScraper.new("https://google.com/")
p s.url
