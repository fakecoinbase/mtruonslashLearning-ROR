require 'nokogiri'
require 'open-uri'

module Scraper
  def scrape
    raise "Not implemented"
  end
end

class RFDScraper
  include Scraper

  attr_accessor :doc

  def initialize(url)
    # Static page for exercise
    html = open(url)
    @doc = Nokogiri::HTML(open(html))
    puts "Searching: #{url}"
  end

  def scrape
    results = []

    # Traverses each thread_info_title HTML
    threads.each do |thread|
      score = 0
      scoreHTML = thread.css('dl').css('.post_voting').attribute('data-total')
      titleHTML = thread.css('a').css('.topic_title_link').text

      if !scoreHTML.nil?    
        multiplier = (scoreHTML.value[0,1] == '-') ? -1 : 1
        length = scoreHTML.value.length
        score = scoreHTML.value[1,length].to_i * multiplier
      end

      results << [titleHTML.strip, score]
    end
   
    # Return populated tuple list (thread_title, vote_score)  
    return results
  end

  private
    def threads
      @doc.css('.inner').css('.thread_info_title')
    end
end

# Running the scraper for tests
url = "http://forums.redflagdeals.com/hot-deals-f9/"
scraper = RFDScraper.new(url)
res = scraper.search_hot_threads
res.each do |thread|
  puts "#{thread[1]}, #{thread[0]}"
end
