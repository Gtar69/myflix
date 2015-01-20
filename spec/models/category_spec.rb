require 'spec_helper'

describe Category do
  it { should have_many(:videos)}

  #it "save itself" do
  #  category = Category.new(name: "comedies")
  #  category.save
  #  expect(Category.first).to eq(category)
  #end

  #pending "add some examples to (or delete) #{__FILE__}"
  #it "has many videos" do 
  #  cat_01 = Category.create(name: "TV Commodies")
  #  v_01 = Video.create(title: "family guy",description: 
  #    "family guy test! ! !", category: cat_01)
  #  v_02 = Video.create(title: "south park",description: 
  #    "south park test! ! !", category: cat_01)
  #  expect(cat_01.videos).to include(v_01, v_02)
  #end
end
