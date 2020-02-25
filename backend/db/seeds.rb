# Start by grabbing the seed data

seed_data_path = File.expand_path("./seed-data.json", __dir__)
seed_data = JSON.parse(IO.read(seed_data_path))

seed_data.each do |json_data|
  # Pass this off to a service object, avoid too much logic here
  ImportFlightData.call(json_data)
end