require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}

  describe "search_by_title" do

    it "shouldn't return anything but empty array if no title pattern match" do
      family_guy = Video.create(title: "family_guy", description: "in Fox 5")
      family_guy2 = Video.create(title: "family_guy_2", description: "also in Fox 5")
      hell_kitchen = Video.create(title: "hell kitchen", description: "in ABC") 
      expect(Video.search_by_title("geogre")).to eq([])
    end

    it "returns videos which cotain title pattern" do 
      family_guy = Video.create(title: "family_guy", description: "in Fox 5")
      family_guy2 = Video.create(title: "family_guy_2", description: "also in Fox 5")
      hell_kitchen = Video.create(title: "hell kitchen", description: "in ABC") 
      expect(Video.search_by_title("family")).to include(family_guy, family_guy2)
    end

    it "return an empty array for searching with empty string" do
      family_guy = Video.create(title: "family_guy", description: "in Fox 5")
      family_guy2 = Video.create(title: "family_guy_2", description: "also in Fox 5")
      hell_kitchen = Video.create(title: "hell kitchen", description: "in ABC") 
      expect(Video.search_by_title("")).to eq([])
    end
  
  end
  #it "save itself" do
  #  video= Video.new(title: "test_01",description: "test test test!")
  #  video.save
    #Video.first.title.should == "test_01"
    #Video.first.should eq(video)
    #Video.first.should == video
  #  expect(Video.first).to eq(video) 
  #end
  # rake db:test:prepare
  #pending "add some examples to (or delete) #{__FILE__}"
  #it "has belongs to category" do 
  #  commody = Category.create(name: "TV Commody" )
  #  video= Video.create(title: "test_01",description: 
  #    "test test test!", category: commody)
  #  expect(video.category).to eq(commody)
  #end

  #it "must have a title" do 
  #  south = Video.create(description: "a great video")
  #  expect(Video.count).to eq(0) 
  #end

  #it "must have a description" do
  #  south = Video.create(title: "south park")
  #  expect(Video.count).to eq(0)
  #end
end
