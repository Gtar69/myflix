Fabricator(:video) do 
  title {Faker::Name.title}
  description {Faker::Lorem.paragraph}
end