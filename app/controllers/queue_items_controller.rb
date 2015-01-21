class QueueItemsController < ApplicationController
  before_filter :require_user
 
  def index
    #binding.pry
    @queue_items = current_user.queue_items
  end

end
