# frozen_string_literal: true

require 'extra_print'
require 'nokogiri'
require 'http'
require 'pry'

class CoBerlin
  def self.scrape
    page = HTTP.get("https://www.co-berlin.org/en/calender").to_s
    noko_page = Nokogiri::HTML(page)

    noko_page.css('.seite-c-single').map do |event|
      {
        title: event.css('.article-title').text,
        when: event.css('.article-over-title').text,
        description: event.css('.article-text').text,
        source: 'C/O Berlin'
      }
    end
  end
end
