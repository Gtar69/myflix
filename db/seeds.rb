# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

family_guy = Video.create(title: "family guy", description: 
	"funny episode", small_cover_url: "family_guy",
	large_cover_url: "family_guy")
south_park = Video.create(title: "south park", description: 
	"south park", small_cover_url: "south_park",
	large_cover_url: "south_park")

cat_1 = Category.create(name: "TV Commodies")
cat_2 = Category.create(name: "TV show")

cat_1.videos << family_guy
