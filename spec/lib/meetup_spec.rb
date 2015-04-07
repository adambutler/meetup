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
    before do
      Meetup.configure do |config|
        config.api_key = ENV["MEETUP_API_KEY"]
      end
    end

    context "#all_events" do
      it "returns every event" do
        events = Meetup.all_events({ group_urlname: ENV["MEETUP_GROUP_URL_NAME"] })
        expect(events).to be_a(Array)
        expect(events.first["name"]).to be_a(String)

        expect(events.first["time"]).to be < (Time.now.to_f * 1000).to_i
        expect(events.last["time"]).to be > (Time.now.to_f * 1000).to_i
      end
    end

    context "#events" do
      it "returns events" do
        events = Meetup.events({ group_urlname: ENV["MEETUP_GROUP_URL_NAME"] })
        expect(events).to be_a(Array)
        expect(events.first["name"]).to be_a(String)
        expect(events.first["time"]).to be > (Time.now.to_f * 1000).to_i
      end

      context "in the past" do
        it "returns events" do
          events = Meetup.events({
            group_urlname: ENV["MEETUP_GROUP_URL_NAME"],
            status: "past"
          })
          expect(events).to be_a(Array)
          expect(events.first["name"]).to be_a(String)
          expect(events.first["time"]).to be < (Time.now.to_f * 1000).to_i
        end
      end
    end
  end

end
