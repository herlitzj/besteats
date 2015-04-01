require 'nokogiri'
require 'open-uri'

#returns a list of url links to all most recent reviews
def linkReturn(url)
  data = Nokogiri::HTML(open(url))
  links = data.css('.content-unit')
  allUrl = links.css('h2.title a').map { |var| var['href'] }
  allUrl.each do |i|
    puts scraper(i)
    puts ''
  end
end

#scrapes name, neighborhood, street address, etc. out of review
def scraper(url2)
  dataUrl = Nokogiri::HTML(open(url2))
  linksUrl = dataUrl.css('section.content-unit')
  
    linksUrl.each do |review|
      arr = []
      # name
      arr << review.css('h2.venue-name').text.strip
      # neighborhood
      arr << review.css('span.neighborhood').text.strip
      # street-address
      arr << review.css('span.street-address').text.strip
      # street-address
      arr << review.css('span.locality').text.strip
      # price rating
      arr << review.css('span.price').text.strip
      # stars
      arr << 4-review.css('span.rating i.empty').count
      #strong
      arr << review.css('p').css('strong').text

      return arr
    end    
end

linkReturn("http://newyork.seriouseats.com/reviews/")