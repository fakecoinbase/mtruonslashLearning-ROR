require 'nokogiri'
require 'open-uri'

module ProductScraper
  include Nokogiri
  include OpenURI

  class Scraper
    USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36"
    attr_reader :products
    attr_accessor :url

    def initialize(url = "")
      @products = []
      @url = url
      @doc = nil
    end

    private
      def html_scrape_for(prices)
        create_doc()
        if prices.first.nil?
          return 0.0
        else
          # Applies a regular expression for a price format dd.dd and converts it to a float
          return prices.first.text[/\d+(\.)*\d+/].to_f
        end
      end

      def create_doc()
        begin
          html = open(@url, "User-Agent" => USER_AGENT)
        rescue OpenURI::HTTPError => error
          response = error.io
          return response
        end
        @doc = Nokogiri::HTML(html)
      end
  end
end
