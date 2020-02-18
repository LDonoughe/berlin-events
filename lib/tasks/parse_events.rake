# frozen_string_literal: true

require_relative './parse_events.rb'

desc 'scrape sites'
task scrape: :environment do
  puts "Current Event Count: #{Event.count}"
  puts 'scraping C/O Berlin Events'
  CoBerlin.scrape
  puts "Current Event Count: #{Event.count}"
  
  puts 'scraping Berghain Events'
  Berghain.scrape
  puts "Current Event Count: #{Event.count}"
end
