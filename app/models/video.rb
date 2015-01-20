class Video < ActiveRecord::Base
  belongs_to :category 
  validates_presence_of :title, :description
  has_many :reviews
  has_many :videos, through: :reviews
  scope :search, -> (search_term) {where("title LIKE ?", "%#{search_term}%")}

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    #@s = search_term
    #where("title LIKE ?", "%#{search_term}%")
    search(search_term)
  end
  
  def avg_rating
    avg = 0.0
    reviews.map {|review| avg = avg + review.rating }
    (avg = avg/reviews.count) if reviews.count > 0
    avg
  end  

end
