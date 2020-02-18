# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require './lib/tasks/parse_events.rb'

# Fix times later
describe CoBerlin do
  it 'creates events' do
    expect(Event.count).to eq 0
    CoBerlin.scrape
    expect(Event.count).to eq 10
    expect(Event.last.start).to be < Event.last.last

    # uniqueness
    CoBerlin.scrape
    expect(Event.count).to eq 10
  end
end

describe Berghain do
  it 'creates events' do
    expect(Event.count).to eq 0
    Berghain.scrape
    expect(Event.count).to eq 17
    # fix this later
    expect(Event.last.start).to be <= Event.last.last

    # uniqueness
    Berghain.scrape
    expect(Event.count).to eq 17
  end
end
