require 'factory_bot'

FactoryBot.define do
  factory :event do
    title { |n| "Event Number #{n}" }
  end
end
