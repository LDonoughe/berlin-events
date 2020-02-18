# frozen_string_literal: true
require 'extra_print'

class EventController < ApplicationController
  # Rails shouldn't attempt to run query until we use results
  def index
    @events = Event.order(:start)
    unless filter_params.empty?
      eap filter_params
      if filter_params['source'] && filter_params['source'] != 'All'
        @events = @events.where(source: filter_params['source'])
      end
      if filter_params['date'] && filter_params['date'].to_i != 0
        date = Date.parse("#{filter_params["date(1i)"]}/#{filter_params["date(2i)"]}/#{filter_params["date(3i)"]}")
        @events = @events.where(start: (date - 1.year)..date, last: date..(date + 1.year))
      end
    end
    @sources = ['All'] + Event.distinct.pluck(:source)
  end

  def filter_params
    # params.permit!
    params.require(:filters).permit! # permit(:source, :date, :text)
  end
end
