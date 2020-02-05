FactoryBot.define do
  factory :flight do
    reference_number { Faker::Number.number(digits: 3) }
    details { Faker::Lorem.sentence }
    launch_successful { Faker::Boolean.boolean }
    is_reused { Faker::Boolean.boolean }
    local_launched_at { Faker::Time.between_dates(from: 5.years.ago, to: 3.years.ago) }

    links {
      links_hash = {
        "mission_patch":       Faker::Internet.url,
        "mission_patch_small": Faker::Internet.url,
        "article_link":        Faker::Internet.url
      }
      # Randomly add reddit or not. Using real links
      if Faker::Boolean.boolean
        links_hash.merge!(
          {
            "reddit_campaign": Faker::Internet.url,
            "reddit_launch":   Faker::Internet.url,
            "reddit_recovery": Faker::Internet.url,
            "reddit_media":    Faker::Internet.url
          }
        )
      end

      links_hash
    }
    rocket

  end
end
