# frozen_string_literal: true

class EventController < ApplicationController
  # Rails shouldn't attempt to run query until we use results
  def index
    @events = Event.order(:start)
    unless filter_params.empty?
      filtered_params = filter_params['filters']
      if filtered_params['source'] && filtered_params['source'] != 'All'
        @events = @events.where(source: filtered_params['source'])
      end
      if filtered_params['date'] && filtered_params['date'].to_i != 0
        date = Date.parse("#{filtered_params['date(1i)']}/#{filtered_params['date(2i)']}/#{filtered_params['date(3i)']}")
        @events = @events.where(start: (date - 1.year)..date, last: date..(date + 1.year))
      end
      if filtered_params['search']
        fuzzy_match = "%#{filtered_params['search']}%"
        # case matters here, could expand to fit that. Could also clean this up.
        # Should probably do both
        @events = @events.where('title LIKE ?', fuzzy_match)
                         .or(@events.where('description LIKE ?', fuzzy_match))
      end
    end
    @sources = ['All'] + Event.distinct.pluck(:source)
  end

  def filter_params
    params.permit(filters: %i[source date search])
  end
end
