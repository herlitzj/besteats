require 'nokogiri'
require 'open-uri'

#returns a list of url links to all most recent reviews
def linkReturn(url)
  data = Nokogiri::HTML(open(url))
  links = data.css('.new-restaurants')
  allUrl = links.css('p a').map { |var| var['href'] }
  allUrl.each do |i|
    puts scraper(i)
    puts ''
    #puts i
  end
end

#scrapes name, neighborhood, street address, etc. out of review
def scraper(url2)
  dataUrl = Nokogiri::HTML(open(url2))
  linksUrl = dataUrl.css('section.content-unit')
  
    linksUrl.each do |review|
      arr = []
      # name
      arr << review.css('div#nameAddress h1.item').text.strip
      # neighborhood
      #arr << review.css('span.neighborhood').text.strip
      # street-address
      #arr << review.css('span.street-address').text.strip
      # street-address
      #arr << review.css('span.locality').text.strip
      # price rating
      #arr << review.css('span.price').text.strip
      # rating
      arr << review.css('div#ratingPrice div.h6 a.v2').text.strip
      #strong
      #arr << review.css('p').css('strong').text

      return arr
    end    
end

linkReturn("http://www.gayot.com/new-restaurants/new-york-area_1ny.html")