FactoryBot.define do
  factory :rocket do
    reference_number { Faker::Alphanumeric.alphanumeric(number: 5) }
    name { Faker::Space.nasa_space_craft }
    type_name { Faker::Space.launch_vehicle }
  end
end
