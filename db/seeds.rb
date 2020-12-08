# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Since rides data can be static, seeding them here to populate them
Ride.create([
  { name: "Transformers: The Ride 3D", capacity: 32, duration: 4.5, sensor_code: "ride-1" },
  { name: "Battlestar Galactica", capacity: 40, duration: 3, sensor_code: "ride-2" },
  { name: "Revenge of the Mummy", capacity: 18, duration: 5, sensor_code: "ride-3" }
])