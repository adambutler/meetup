require 'active_support'
require 'httparty'

class Meetup
  include HTTParty
  base_uri 'api.meetup.com'

  def initialize(api_key)
    @options = { query: { key: api_key } }
  end

  def events(options = {})
    options = @options.dup.deep_merge({query: options})
    self.class.get("/2/events", options)
  end
end

meetup = Meetup.new("")
puts meetup.events({ group_urlname: "bristoljs" }).body
