require 'nokogiri'
require 'open-uri'

#returns a list of url links to all most recent reviews
def linkReturn(url)
  data = Nokogiri::HTML(open(url))
  links = data.css('div.case')
  allUrl = links.css('h3 a').map { |var| var['href'] }
  allUrl.each do |i|
    puts scraper(i)
    puts ''
    puts i
  end
end

#scrapes name, neighborhood, street address, etc. out of review
def scraper(url2)
  dataUrl = Nokogiri::HTML(open(url2))
  linksUrl = dataUrl.css('div.place-post')
  
    linksUrl.each do |review|
      arr = []
      # name
      arr << review.css('#main-content-title').text.strip
      # neighborhood
      arr << review.css('span.date').text.strip
      # street-address
      #arr << review.css('span.street-address').text.strip
      # street-address
      #arr << review.css('span.locality').text.strip
      # food rating
      arr << review.css('span.i-box[1] span.i-number').text.strip
      # decor rating
      arr << review.css('span.i-box[2] span.i-number').text.strip
      #service rating
      arr << review.css('span.i-box[3] span.i-number').text.strip
      #cost rating
      arr << review.css('span.i-box[4] span.i-number').text.strip

      return arr
    end    
end

linkReturn("https://www.zagat.com/p/new-york-city")