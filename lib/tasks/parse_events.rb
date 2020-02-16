# frozen_string_literal: true

require 'extra_print'
require 'nokogiri'
require 'http'
require 'pry'

class CoBerlin
  def self.scrape
    page = HTTP.get('https://www.co-berlin.org/en/calender').to_s
    noko_page = Nokogiri::HTML(page)

    noko_page.css('.seite-c-single').map do |event|
      # binding.pry unless event.css('.article-over-title').text.match(/[0-9\/*]+\sto\s([0-9\/*]+)/)
      start = event.css('.article-over-title').text.match(/[0-9\/*]+/).to_s
      last = event.css('.article-over-title').text.match(/[0-9\/*]+\sto\s([0-9\/*]+)/)
      Event.create(
        title: event.css('.article-title').text,
        when: event.css('.article-over-title').text,
        start: Date.strptime(start, '%d/%m/%y'),
        end: Date.strptime(last && last[1] || start, '%d/%m/%y'), 
        description: event.css('.article-text').text,
        source: 'C/O Berlin'
      )
    end
  end
end

class Berghain
  def self.scrape

  end
end
