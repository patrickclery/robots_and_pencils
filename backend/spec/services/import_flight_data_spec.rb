RSpec.describe ImportFlightData, type: :service do
  subject(:import_flight_data) { described_class.call(flight_data) }

  # Taken from the first item in seed-data.json
  let!(:raw_json) {
    <<JSON
      {
        "flight_number":           1,
        "mission_name":            "FalconSat",
        "mission_id":              [],
        "upcoming":                false,
        "launch_year":             "2006",
        "launch_date_unix":        1143239400,
        "launch_date_utc":         "2006-03-24T22:30:00.000Z",
        "launch_date_local":       "2006-03-25T10:30:00+12:00",
        "is_tentative":            false,
        "tentative_max_precision": "hour",
        "tbd":                     false,
        "launch_window":           0,
        "rocket":                  {
          "rocket_id":    "falcon1",
          "rocket_name":  "Falcon 1",
          "rocket_type":  "Merlin A",
          "first_stage":  {
            "cores": [
                       {
                         "core_serial":     "Merlin1A",
                         "flight":          1,
                         "block":           null,
                         "gridfins":        false,
                         "legs":            false,
                         "reused":          false,
                         "land_success":    null,
                         "landing_intent":  false,
                         "landing_type":    null,
                         "landing_vehicle": null
                       }
                     ]
          },
          "second_stage": {
            "block":    1,
            "payloads": [
                          {
                            "payload_id":       "FalconSAT-2",
                            "norad_id":         [],
                            "reused":           false,
                            "customers":        [
                                                  "DARPA"
                                                ],
                            "nationality":      "United States",
                            "manufacturer":     "SSTL",
                            "payload_type":     "Satellite",
                            "payload_mass_kg":  20,
                            "payload_mass_lbs": 43,
                            "orbit":            "LEO",
                            "orbit_params":     {
                              "reference_system":   "geocentric",
                              "regime":             "low-earth",
                              "longitude":          null,
                              "semi_major_axis_km": null,
                              "eccentricity":       null,
                              "periapsis_km":       400,
                              "apoapsis_km":        500,
                              "inclination_deg":    39,
                              "period_min":         null,
                              "lifespan_years":     null,
                              "epoch":              null,
                              "mean_motion":        null,
                              "raan":               null,
                              "arg_of_pericenter":  null,
                              "mean_anomaly":       null
                            }
                          }
                        ]
          },
          "fairings":     {
            "reused":           false,
            "recovery_attempt": false,
            "recovered":        false,
            "ship":             null
          }
        },
        "ships":                   [],
        "telemetry":               {
          "flight_club": null
        },
        "reuse":                   {
          "core":       false,
          "side_core1": false,
          "side_core2": false,
          "fairings":   false,
          "capsule":    false
        },
        "launch_site":             {
          "site_id":        "kwajalein_atoll",
          "site_name":      "Kwajalein Atoll",
          "site_name_long": "Kwajalein Atoll Omelek Island"
        },
        "launch_success":          false,
        "launch_failure_details":  {
          "time":     33,
          "altitude": null,
          "reason":   "merlin engine failure"
        },
        "links":                   {
          "mission_patch":       "https://images2.imgbox.com/40/e3/GypSkayF_o.png",
          "mission_patch_small": "https://images2.imgbox.com/3c/0e/T8iJcSN3_o.png",
          "reddit_campaign":     "https://www.reddit.com/r/spacex/comments/4gyh8z",
          "reddit_launch":       "https://www.reddit.com/r/spacex/comments/4htenu",
          "reddit_recovery":     "https://www.reddit.com/r/spacex/comments/4ihp1p",
          "reddit_media":        "https://www.reddit.com/r/spacex/comments/4htg2g",
          "presskit":            null,
          "article_link":        "https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html",
          "wikipedia":           "https://en.wikipedia.org/wiki/DemoSat",
          "video_link":          "https://www.youtube.com/watch?v=0a_00nJ_Y88",
          "youtube_id":          "0a_00nJ_Y88",
          "flickr_images":       []
        },
        "details":                 "Engine failure at 33 seconds and loss of vehicle",
        "static_fire_date_utc":    "2006-03-17T00:00:00.000Z",
        "static_fire_date_unix":   1142553600,
        "timeline":                {
          "webcast_liftoff": 54
        },
        "crew":                    null
      }
JSON
  }
  let!(:flight_data) { JSON.parse(raw_json) }

  it { should be true }
  it { expect(described_class).to respond_to(:call) }
  it { expect { subject }.to change { Flight.count }.by(1) }
  it { expect { subject }.to change { Rocket.count }.by(1) }

  context "after import" do
    before { import_flight_data }
    subject(:resulting_flight) { Flight.find_by_reference_number(flight_data["flight_number"]) }
    let(:attributes) {
      {
        reference_number:  1,
        details:           "Engine failure at 33 seconds and loss of vehicle",
        launch_successful: false,
        is_reused:         false,
        launched_at:       Time.parse("2006-03-24T22:30:00.000Z"),
        local_utc_offset:   "+12:00",
        links:             {
                             mission_patch:       "https://images2.imgbox.com/40/e3/GypSkayF_o.png",
                             mission_patch_small: "https://images2.imgbox.com/3c/0e/T8iJcSN3_o.png",
                             reddit_campaign:     "https://www.reddit.com/r/spacex/comments/4gyh8z",
                             reddit_launch:       "https://www.reddit.com/r/spacex/comments/4htenu",
                             reddit_recovery:     "https://www.reddit.com/r/spacex/comments/4ihp1p",
                             reddit_media:        "https://www.reddit.com/r/spacex/comments/4htg2g",
                             article_link:        "https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html"
                           }.stringify_keys,
      }
    }
    it { should have_attributes(details: attributes[:details]) }
    it { should have_attributes(links: attributes[:links]) }
    it { should have_attributes(launched_at: attributes[:launched_at]) }
    it { should have_attributes(local_utc_offset: attributes[:local_utc_offset]) }
    it { should have_attributes(is_reused: attributes[:is_reused]) }
    it { should have_attributes(launch_successful: attributes[:launch_successful]) }
    it { should have_attributes(reference_number: attributes[:reference_number]) }
  end

  # We don't want duplicate flights or rockets
  context 'When a flight already exists' do
    let!(:existing_flight) { create(:flight, reference_number: flight_data["flight_number"]) }
    it { expect { subject }.not_to change { Flight.count } }
    it { expect { subject }.to change { Rocket.count }.by(1) }
  end

  context 'When a rocket already exists' do
    let!(:existing_rocket) { create(:rocket, reference_number: flight_data["rocket"]["rocket_id"]) }
    it { expect { subject }.to change { Flight.count }.by(1) }
    it { expect { subject }.not_to change { Rocket.count } }
  end

end