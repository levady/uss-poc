# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Since rides data can be static, seeding them here to populate them
Ride.create([
  { name: "Transformers: The Ride 3D", duration: 3, capacity: 6, sensor_code: "ride-1" },
  { name: "Battlestar Galactica", duration: 7, capacity: 30, sensor_code: "ride-2" },
  { name: "Revenge of the Mummy", capacity: 18, duration: 5, sensor_code: "ride-3" }
])

collection_time = Time.now
ride1 = Ride.find_by(sensor_code: "ride-1")
ride2 = Ride.find_by(sensor_code: "ride-2")
Visitor.create([
  { ride: ride1, visitors_count: 20, collected_at: collection_time },
  { ride: ride1, visitors_count: 12, collected_at: collection_time + 3.minutes },
  { ride: ride1, visitors_count: -4, collected_at: collection_time + 1.minute },
  { ride: ride2, visitors_count: 50, collected_at: collection_time },
  { ride: ride2, visitors_count: -11, collected_at: collection_time + 1.minute },
  { ride: ride2, visitors_count: 40, collected_at: collection_time + 7.minute },
  { ride: ride1, visitors_count: 50, collected_at: collection_time - 1.day },
  { ride: ride2, visitors_count: -11, collected_at: collection_time + 1.day }
])
