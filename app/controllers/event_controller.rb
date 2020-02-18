# frozen_string_literal: true

class EventController < ApplicationController
  # TODO: add filters
  def index
    @events = Event.all
  end
end
