class Video < ActiveRecord::Base
  belongs_to :category 
  validates_presence_of :title, :description
  has_many :reviews
  has_many :queue_items
  scope :search, -> (search_term) {where("title LIKE ?", "%#{search_term}%")}

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    search search_term  
  end
  
  def avg_rating
    rating_avg = 0.0
    reviews.map {|review| rating_avg = rating_avg + review.rating }
    (rating_avg = rating_avg/reviews.count) if reviews.count > 0
    rating_avg.round(1)
  end  

end
