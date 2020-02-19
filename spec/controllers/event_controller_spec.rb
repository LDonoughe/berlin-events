# frozen_string_literal: true

require 'rails_helper'
require_relative '../../lib/tasks/parse_events.rb'

RSpec.describe EventController do
  # FIXME: These are pretty much all happy path tests
  describe 'GET index' do
    # usually we would use a factory instead
    let!(:event) { Event.create(title: 'test') }
    it 'assigns @events' do
      get :index
      expect(assigns(:events).first).to eq Event.first
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    context 'with filters' do
      let!(:event) { Event.create(title: '1 test 1', source: 'test') }
      let!(:event2) { Event.create(title: 'Klubnacht', source: 'Berghain') }

      it 'finds an exact name match' do
        get :index, params: { filters: { 'search': '1 test 1' } }
        expect(assigns(:events).first).to eq Event.first
      end

      it 'finds a partial match' do
        get :index, params: { filters: { 'search': 'test' } }
        expect(assigns(:events).first).to eq Event.first
      end

      it 'sources properly' do
        get :index, params: { filters: { 'source': 'test' } }
        expect(assigns(:events).first).to eq Event.first
      end

      # TODO: Date filter tests
    end
  end
end
