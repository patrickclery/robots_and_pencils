class FlightSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attribute :details,
            :id,
            :is_reused,
            :launch_successful,
            :launched_at,
            :rocket_name,
            :rocket_type,
            :reference_number

  link :mission_patch do |flight|
    flight.links[:mission_patch]
  end
  link :mission_patch_small do |flight|
    flight.links[:mission_patch_small]
  end
  link :article_link do |flight|
    flight.links[:article_link]
  end
  link :reddit_campaign do |flight|
    flight.links[:reddit_campaign]
  end
  link :reddit_launch do |flight|
    flight.links[:reddit_launch]
  end
  link :reddit_recovery do |flight|
    flight.links[:reddit_recovery]
  end
  link :reddit_media do |flight|
    flight.links[:reddit_media]
  end

end