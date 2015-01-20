require 'spec_helper'

describe Category do
  it { should have_many(:videos)}

  describe "#recent_videos" do

    it "returns 6 videos if there are more than 6 videos in the category" do
      comedies = Category.create(name: "comedies")
      for i in 1..8
        vvv = Video.create(title: "family guy"+i.to_s ,description: 
          "family guy test! ! !", category: comedies)
      end
      expect(comedies.recent_videos.count).to eq(6)
    end

    it "returns 6 videos in desc order" do 
      comedies = Category.create(name: "comedies")
      videos = []
      for i in 0..8
        videos[i] = Video.create(title: "family guy"+i.to_s ,description: 
          "family guy test! ! !", category: comedies, created_at: Time.now+(60*i) )
      end
      
      expect(comedies.recent_videos).to eq([videos[8],videos[7],videos[6],
        videos[5],videos[4],videos[3]])
    end

  end

end
