require 'active_support'
require 'httparty'

class Meetup
  include HTTParty

  base_uri 'api.meetup.com'

  def initialize(api_key)
    @options = {
      query: {
        key: api_key
      }
    }
  end

  def events(options = {})
    options = @options.dup.deep_merge({query: options})
    response = self.class.get("/2/events", options)
    case response.code
    when 200
      return response["results"]
    end
  end
end

meetup = Meetup.new("")

meetup.events({ group_urlname: "bristoljs" }).each do |event|
  puts event["name"]
end
