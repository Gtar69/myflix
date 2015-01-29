# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
comedies = Category.create(name: "Comedies")
dramas = Category.create(name: "Dramas")

for i in 0..3
Video.create(title: "family guy", description: 
	"funny episode", small_cover_url: "/tmp/family_guy.jpg", 
  large_cover_url: "/tmp/family_guy.jpg", category: comedies)
end

for i in 0..3
Video.create(title: "south park", description: 
	"south park", small_cover_url: "/tmp/south_park.jpg", 
  large_cover_url: "/tmp/south_park.jpg", category: comedies)
end

Video.create(title: "monk", description: 
  "monk la", small_cover_url: "/tmp/monk.jpg", 
  large_cover_url: "/tmp/monk_large.jpg", category: dramas)


