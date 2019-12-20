require 'nokogiri'
require 'open-uri'

module Scraper
  def scrape
    raise "Not implemented"
  end
end

class AmazonScraper
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
    # Traverses each thread_info_title HTML
    threads.each do |thread|
      puts thread.text
    end
   
    # Return populated tuple list (thread_title, vote_score)  
    return results
  end

  private
    def threads
      @doc.css('div#price').css('span#priceblock_ourprice')
    end
end

# Running the scraper for tests
product_url = "https://www.amazon.ca/gp/product/B00WRDS0AU?pf_rd_p=05326fd5-c43e-4948-99b1-a65b129fdd73&pf_rd_r=ECHQYPX9MEJ7JD9TC7VE"
scraper = AmazonScraper.new(product_url)
scraper.scrape
