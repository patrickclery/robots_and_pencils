FactoryBot.define do
  factory :flight do
    reference_number { Faker::Number.number(digits: 3) }
    details { Faker::Lorem.sentence }
    launch_successful { Faker::Boolean.boolean }
    is_reused { Faker::Boolean.boolean }
    local_launched_at { Faker::Time.between_dates(from: 5.years.ago, to: 3.years.ago) }

    links {
      {
        "mission_patch":       Faker::Internet.url,
        "mission_patch_small": Faker::Internet.url,
        "article_link":        Faker::Internet.url,
        "reddit_campaign":     '',
        "reddit_launch":       '',
        "reddit_recovery":     '',
        "reddit_media":        ''
      }
    }
    rocket

    trait :with_reddit_links do
      # Randomly add reddit or not. Using real links
      links {
        {
          "mission_patch":       Faker::Internet.url,
          "mission_patch_small": Faker::Internet.url,
          "article_link":        Faker::Internet.url,
          "reddit_campaign":     Faker::Internet.url,
          "reddit_launch":       Faker::Internet.url,
          "reddit_recovery":     Faker::Internet.url,
          "reddit_media":        Faker::Internet.url
        }
      }
    end
  end
end
