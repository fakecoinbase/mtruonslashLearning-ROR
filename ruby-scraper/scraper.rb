require 'nokogiri'
require 'open-uri'


class Scraper
  
  attr_accessor :doc

  def initialize(url)
    # Static page for exercise
    html = open(url)
    @doc = Nokogiri::HTML(open(html))
    puts "Searching: #{url}"
  end

  def search_hot_threads
    results = []
    threads.each do |thread|
      scoreHTML = thread.css('dl').css('.post_voting').attribute('data-total')
      titleHTML = thread.css('a').css('.topic_title_link').text
      score = 0
      if !scoreHTML.nil?    
        multiplier = (scoreHTML.value[0,1] == '-') ? -1 : 1
        length = scoreHTML.value.length
        score = scoreHTML.value[1,length].to_i * multiplier
      end
      results << [titleHTML.strip, score]
    end
    return results
  end

  private
    def threads
      @doc.css('.inner').css('.thread_info_title')
    end
end

# Running the scraper for tests
url = "http://forums.redflagdeals.com/hot-deals-f9/"
scraper = Scraper.new(url)
res = scraper.search_hot_threads
res.each do |thread|
  puts "#{thread[1]}, #{thread[0]}"
end
