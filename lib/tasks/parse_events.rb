# frozen_string_literal: true

require 'nokogiri'
require 'http'

# Currently testing for uniqueness with different values for different sites
#  but it shouldn't be an issue (and we can change it if it turns out to be)

class CoBerlin
  def self.scrape
    page = HTTP.get('https://www.co-berlin.org/en/calender').to_s
    noko_page = Nokogiri::HTML(page)

    noko_page.css('.seite-c-single').each do |event|
      title = event.css('.article-title').text
      start = event.css('.article-over-title').text.match(%r{[0-9/*]+}).to_s
      start_date = Date.strptime(start, '%d/%m/%y')
      next unless Event.where(title: title, start: start_date).count == 0

      last = event.css('.article-over-title').text.match(%r{[0-9/*]+\sto\s([0-9/*]+)})
      Event.create(
        title: title,
        when: event.css('.article-over-title').text,
        start: start_date,
        last: Date.strptime(last && last[1] || start, '%d/%m/%y'),
        description: event.css('.article-text').text,
        source: 'C/O Berlin'
      )
    end
  end
end

class Berghain
  def self.scrape
    page = HTTP.get('https://www.berghain.berlin/en/program/').to_s
    noko_page = Nokogiri::HTML(page)

    noko_page.css('.upcoming-event').each do |event|
      title = event.css('h2').text.strip
      date = event.css('p').first.text
      next unless Event.where(title: title, when: date).count == 0

      Event.create(
        title: title,
        when: date,
        start: DateTime.parse(date),
        last: DateTime.parse(date),
        description: event.css('h3').text + '\n' + event.css('h4').text,
        source: 'Berghain'
      )
    end
  end
end
