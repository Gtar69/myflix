class User < ActiveRecord::Base
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  has_secure_password
  has_many :reviews
  has_many :queue_items, -> {order(position: :asc)}
  has_many :videos, through: :queue_items

  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end
end
