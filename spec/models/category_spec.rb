require 'spec_helper'

describe Category do
  it { should have_many(:videos)}

  describe "#recent_videos" do
    let(:videos) do
      @comedies = Category.create(name: "comedies")
      @videos = []
      (1..8).to_a.each do |i|  
        @videos[i] = Video.create(title: "family guy"+i.to_s ,description: 
          "family guy test! ! !", category: @comedies)
      end
    end

    it "returns 6 videos if there are more than 6 videos in the category" do
      videos
      expect(@comedies.recent_videos.count).to eq(6)
    end

    it "returns 6 videos in desc order" do
      videos
      expect(@comedies.recent_videos).to eq([@videos[8],@videos[7],@videos[6],
        @videos[5],@videos[4],@videos[3]])
    end

  end

end
