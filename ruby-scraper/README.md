Ruby Scraper
============

A ruby scraper module (interface) and implementation for a redflagdeal's hot threads subforums data scraper.
The scraper parses HTML to extract target data and output it in a desirable form factor.

The inherited Amazon Scraper requires the use of user agent information.

To-do / Goals
-----------
* Detect system user agent information

Challenges
-----------
Originally, I wanted to scrape the Amazon marketplace for relevant price tracking, however, Amazon's security measures blocks my crude scrape. Existing solutions leverage Amazon's advertising API to collect price information. Scraping should be used in instances where an API is not available anyways.

Further investigation lead to the inclusion of a header (user-agent information) to bypass.

Dependencies
------------
* Nokogiri
* Open-uri
