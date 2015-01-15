class Category < ActiveRecord::Base
  has_many :videos#, ->{order("title")}
  #->{order("created_at DESC")} 
  #
  
  def recent_videos
    videos.order("created_at DESC").first(6)   
  end
end
