# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :event do
    title { |n| "Event Number #{n}" }
    timing { ' Friday 28.02.2020 start 23:59' }
    description { 'Klubnacht' }
    source { 'Berghain' }
    start { 1.week.ago }
    last { 1.day.ago }
    url { |n| "https://www.berghain.berlin/en/event/#{n}/" }
  end
end
