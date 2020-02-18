# frozen_string_literal: true

require 'nokogiri'
require 'http'

class CoBerlin
  def self.scrape
    page = HTTP.get('https://www.co-berlin.org/en/calender').to_s
    noko_page = Nokogiri::HTML(page)

    noko_page.css('.seite-c-single').each do |event|
      start = event.css('.article-over-title').text.match(%r{[0-9/*]+}).to_s
      last = event.css('.article-over-title').text.match(%r{[0-9/*]+\sto\s([0-9/*]+)})
      Event.create(
        title: event.css('.article-title').text,
        when: event.css('.article-over-title').text,
        start: Date.strptime(start, '%d/%m/%y'),
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
      date = event.css('p').first.text
      Event.create(
        title: event.css('h2').text.strip,
        when: date,
        start: DateTime.parse(date),
        last: DateTime.parse(date),
        description: event.css('h3').text + '\n' + event.css('h4').text,
        source: 'Berghain'
      )
    end
  end
end
