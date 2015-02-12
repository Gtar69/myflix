class Review < ActiveRecord::Base
  belongs_to :user 
  belongs_to :video
  validates_presence_of :content, :rating

  #def user
  #  User.find(self.user_id)
  #end

end
