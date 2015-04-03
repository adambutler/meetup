require 'meetup'

RSpec.describe Meetup do
  before(:all) do
    Meetup.configure do |config|
      config.api_key = ""
    end
  end

  it "returns events" do
    events = Meetup.events({ group_urlname: "bristoljs" })
  end

end
