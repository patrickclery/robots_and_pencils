RSpec.describe FlightSerializer, type: :serializer do

  subject(:flight_as_json) { FlightSerializer.new(flight).serialized_json }
  let!(:flight) { create(:flight) }

  describe "attributes" do
    subject { JSON.parse(flight_as_json)["data"]["attributes"] }

    it { expect(subject.keys).to contain_exactly "details",
                                                 "formattedDate",
                                                 "id",
                                                 "isReused",
                                                 "launchSuccessful",
                                                 "launchedAt",
                                                 "localUtcOffset",
                                                 "referenceNumber",
                                                 "rocketName",
                                                 "rocketType" }
  end
  describe "links" do
    subject { JSON.parse(flight_as_json)["data"]["links"] }
    it { expect(subject.keys).to contain_exactly "articleLink",
                                                 "missionPatch",
                                                 "missionPatchSmall",
                                                 "redditCampaign",
                                                 "redditLaunch",
                                                 "redditMedia",
                                                 "redditRecovery" }
  end

end
