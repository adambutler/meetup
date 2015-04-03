require 'active_support'
require 'httparty'

module Meetup

  class << self
    attr_accessor :configuration
  end

  def self.events(events_options)
    options = self.options.dup.deep_merge({query: events_options})

    response = HTTParty.get("#{@base_uri}/2/events", options)
    case response.code
    when 200
      return response["results"]
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

end
