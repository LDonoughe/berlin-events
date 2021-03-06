# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require './lib/tasks/parse_events.rb'

# Not following test best practices but this does save a bunch of HTTP requests
# FIXME: use best testing practices
# FIXME: Fix times later
describe CoBerlin do
  before do
    stub_request(:get, 'https://www.co-berlin.org/en/calender')
      .to_return(status: 200, body: file_fixture('coberlin.html').read, headers: {})
  end

  it 'creates events' do
    expect(Event.count).to eq 0
    CoBerlin.scrape
    expect(Event.count).to eq 8
    expect(Event.last.start).to be < Event.last.last
    expect(Event.last.url).not_to be_empty

    # uniqueness
    CoBerlin.scrape
    expect(Event.count).to eq 8
  end

  context 'when site is down' do
    before do
      stub_request(:get, 'https://www.co-berlin.org/en/calender')
        .to_return(status: 500, body: '', headers: {})
    end

    let!(:event) { create(:event) }

    it 'responds in a reasonable fashion' do
      expect(Event.count).to eq 1
      expect(Event.first.title).to eq event.title
      CoBerlin.scrape
      expect(Event.count).to eq 1
      expect(Event.first.title).to eq event.title
    end
  end
end

describe Berghain do
  before do
    stub_request(:get, 'https://www.berghain.berlin/en/program/')
      .to_return(status: 200, body: file_fixture('berghain.html').read, headers: {})
  end

  it 'creates events' do
    expect(Event.count).to eq 0
    Berghain.scrape
    expect(Event.count).to eq 15
    # fix this later
    expect(Event.last.start).to be <= Event.last.last
    expect(Event.last.url).not_to be_empty

    # uniqueness
    Berghain.scrape
    expect(Event.count).to eq 15
  end

  context 'when site is down' do
    before do
      stub_request(:get, 'https://www.berghain.berlin/en/program/')
        .to_return(status: 500, body: '', headers: {})
    end

    let!(:event) { create(:event) }

    it 'responds in a reasonable fashion' do
      expect(Event.count).to eq 1
      expect(Event.first.title).to eq event.title
      Berghain.scrape
      expect(Event.count).to eq 1
      expect(Event.first.title).to eq event.title
    end
  end
end
