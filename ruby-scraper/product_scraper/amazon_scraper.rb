module ProductScraper
  class AmazonScraper < Scraper
    def scrape
      html_scrape_for(prices)
    end

    private
      def prices
        @doc.css('div#price').css('span#priceblock_ourprice')
      end
  end
end
