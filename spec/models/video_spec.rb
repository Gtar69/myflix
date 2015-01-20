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

end
