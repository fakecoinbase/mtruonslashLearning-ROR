require 'nokogiri'
require 'open-uri'


class Scraper
  
  attr_accessor :doc

  def initialize
    # Static page for exercise
    @url = "http://forums.redflagdeals.com/hot-deals-f9/"
    @html = open(@url)
    @doc = Nokogiri::HTML(open(@html))
  end

  def search_hot_threads
    thread_table.each do |item|
      score = item.css('dl').css('.post_voting').attribute('data-total')
      title = item.css('a').css('.topic_title_link').text
      puts score, title
    end
  end

  private
    def thread_table
      @doc.css('.inner').css('.thread_info_title')
    end
end

scraper = Scraper.new
titles = scraper.search_hot_threads
