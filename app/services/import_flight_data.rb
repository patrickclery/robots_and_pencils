# I'm using a service object so I can build the seed feature through Test-Driven Development
class ImportFlightData

  # @param String JSON of flight data
  # @return Boolean true
  def self.call(data)

    # Import the Rocket first since it must exist before Flight
    rocket = Rocket.find_or_initialize_by(reference_number: data["rocket"]["rocket_id"]).then do |obj|
      obj.name      = data["rocket"]["rocket_name"]
      obj.type_name = data["rocket"]["rocket_type"]
      # If anything was reused in "reuse", mark it reused
      obj
    end
    rocket.save!

    # Import the flight itself
    flight = Flight.find_or_initialize_by(reference_number: data["flight_number"]).then do |obj|
      obj.details           = data["details"]
      obj.is_reused         = data["reuse"].any? { |k, v| v === true }
      obj.launch_successful = data["launch_success"]
      obj.launched_at       = Time.parse(data["launch_date_utc"])
      obj.local_utc_offset  = Time.parse(data["launch_date_local"]).formatted_offset
      obj.links             = data["links"].slice("mission_patch",
                                                  "mission_patch_small",
                                                  "reddit_campaign",
                                                  "reddit_launch",
                                                  "reddit_recovery",
                                                  "reddit_media",
                                                  "article_link")

      obj.rocket = rocket
      obj
    end
    flight.save!

    true
  end
end
