# frozen_string_literal: true

require_relative './parse_events.rb'

desc 'scrape co berlin'
task :scrape_co => :environment do
  CoBerlin.scrape
end