require 'nokogiri'
require 'open-uri'

#returns a list of url links to all most recent reviews
def linkReturn(url)
  data = Nokogiri::HTML(open(url))
  links = data.css('.zone_B_with_ads')
  allUrl = links.css('div.tile__content a.tile__read_more').map { |var| var['href'] }
  allUrl.each do |i|
    puts scraper(i)
    puts ''
    #puts i
  end
end

#scrapes name, neighborhood, street address, etc. out of review
def scraper(url2)
  dataUrl = Nokogiri::HTML(open("http://www.timeout.com#{url2}"))
  linksUrl = dataUrl.css('#content')
  
    linksUrl.each do |review|
      arr = []
      # name
      arr << review.css('h1.listing_page_title').text.strip
      # neighborhood
      arr << review.css('span.listings_flag').text.strip
      # street-address
      #arr << review.css('span.street-address').text.strip
      # summary
      arr << review.css('h2.review__summary').text.strip
      # food rating
      arr << review.css('ul.star_rating li.sr-only').text[0]
      #cost rating
      arr << review.css('span.listings_flags__price li.icon_highlight').count

      return arr
    end    
end

linkReturn("http://www.timeout.com/newyork/restaurants")