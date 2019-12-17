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
      score = thread.css('dl').css('.post_voting').attribute('data-total')
      if score.nil?
        score = "NONE"
      end
      title = thread.css('a').css('.topic_title_link').text
      puts "Score: #{ score }" + ", " + "#{ title.strip }"
      results << [title, score]
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
puts "\n\n"
puts res
