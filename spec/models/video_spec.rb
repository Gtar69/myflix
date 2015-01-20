require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
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
