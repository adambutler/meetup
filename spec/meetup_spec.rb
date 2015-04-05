require 'meetup'

RSpec.describe Meetup do
  context "without an API Key" do
    before do
      Meetup.configure do |config|
        config.api_key = nil
      end
    end

    it "raises an error" do
      expect {
        Meetup.events({ group_urlname: ENV["MEETUP_GROUP_URL_NAME"] })
      }.to raise_exception("Missing API Key")
    end
  end

  context "with a valid API Key" do
    context "#events" do
      before do
        Meetup.configure do |config|
          config.api_key = ENV["MEETUP_API_KEY"]
        end
      end

      it "returns events" do
        events = Meetup.events({ group_urlname: ENV["MEETUP_GROUP_URL_NAME"] })
        expect(events).to be_a(Array)
        expect(events.first["name"]).to be_a(String)
      end
    end
  end

end
