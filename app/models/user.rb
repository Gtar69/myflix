class User < ActiveRecord::Base
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  has_secure_password
  has_many :reviews
  has_many :queue_items, -> {order(position: :asc)}
  has_many :videos, through: :queue_items

  has_many :leading_relationships, class_name: "Relationship",
    foreign_key: :leader_id
  #has_many :leaders, through: :relationship

  has_many :following_relationships, class_name: "Relationship",
    foreign_key: :follower_id
  #has_many :follwers, through: :following_relationships

  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end

  def follows?(another_user)
    following_relationships.map(&:leader).include?(another_user)
  end

  def can_follows?(another_user)
    !(self.follows?(another_user) || self == another_user)
  end

end
