require 'active_support'
require 'httparty'

module Meetup

  class << self
    attr_accessor :configuration
  end

  def self.events(events_options)
    preflight

    options = self.options.dup.deep_merge({query: events_options})

    response = HTTParty.get("#{@base_uri}/2/events", options)
    case response.code
    when 200
      return response["results"]
    end
  end

  def self.all_events(events_options)
    past_options = events_options.deep_merge({ status: "past" })

    past_events = events(past_options)
    future_events = events(events_options)
    all_events = past_events + future_events

    all_events.sort_by do |event|
      event["time"]
    end
  end

  def self.options
    @base_uri = "http://api.meetup.com"
    @options = {
      query: {
        key: configuration.api_key
      }
    }
  end

  def self.configuration
    @configuration ||=  Configuration.new
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :api_key

    def initialize
    end
  end

private

  def self.preflight
    unless configuration.api_key
      raise "Missing API Key"
    end
  end

end
