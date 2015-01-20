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
	"funny episode", small_cover_url: "family_guy", 
  large_cover_url: "family_guy", category: comedies)
end

for i in 0..3
Video.create(title: "south park", description: 
	"south park", small_cover_url: "south_park", 
  large_cover_url: "south_park", category: comedies)
end

Video.create(title: "monk", description: 
  "monk la", small_cover_url: "monk", 
  large_cover_url: "monk_large", category: dramas)

#cat_1 = Category.create(name: "TV Commodies")
#cat_2 = Category.create(name: "TV show")
#cat_1.videos << family_guy
