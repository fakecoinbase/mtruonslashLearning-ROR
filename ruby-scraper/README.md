Ruby Scraper
============

A ruby script/scraper which takes the redflagdeal's hot threads subforums  and scrapes the page for data.
Afterwards, parsing it and outputting the data.

Challenges
-----------
Originally, I wanted to scrape the Amazon marketplace for relevant price tracking, however, Amazon's security measures blocks my crude scrape. Existing solutions leverage Amazon's advertising API to collect price information. Scraping should be used in instances where an API is not available anyways.

Dependencies
------------
* Nokogiri
* Open-uri
