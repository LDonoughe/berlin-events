# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require './lib/tasks/parse_events.rb'
# require './app/models/event.rb'

describe CoBerlin do
  it 'creates events' do
    expect(Event.count).to eq 0
    CoBerlin.scrape
    expect(Event.count).to eq 10
  end
end