class User < ActiveRecord::Base
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  has_secure_password
  has_many :reviews
  has_many :queue_items
  has_many :videos, through: :queue_items

  def add_video_to_queue(video,user)
    queue_item = queue_items.build
    queue_item.user = user
    queue_item.video = video
    queue_item.order = queue_items.count + 1
    queue_item.save
  end
end
