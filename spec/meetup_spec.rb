require 'meetup'

RSpec.describe Meetup do
  before(:all) do
    Meetup.configure do |config|
      config.api_key = ENV["MEETUP_API_KEY"]
    end
  end

  it "returns events" do
    events = Meetup.events({ group_urlname: ENV["MEETUP_GROUP_URL_NAME"] })
    expect(events).to be_a(Array)
  end

end
