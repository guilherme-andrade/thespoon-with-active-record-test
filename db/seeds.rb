# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"

Restaurant.destroy_all

url = "https://gist.githubusercontent.com/yoobi55/5d36f13e902a75225a39a8caa5556551/raw/cbd57cfdddbdfc009fd9ccdadf5fb7129af71c73/restaurant-data.json"
restaurants = JSON.parse(open(url).read)['restaurants']

restaurants.each do |r|
	reviews = r["reviews"]
	stars = reviews.collect { |r| r["rating"] / reviews.length }.sum
	restaurant = Restaurant.create(
		name: r["name"],
		address: r["address"],
		stars: stars
	)
	puts "Created Restaurant: #{restaurant.name}"
end
