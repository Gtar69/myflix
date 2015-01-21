class QueueItemsController < ApplicationController
  before_filter :require_user
 
  def index
    @queue_items = current_user.queue_items.order(order: :asc)
    #@q={}
  end

  def destroy
    @queue_item = QueueItem.find(params[:id])
    @queue_item.destroy!
    flash[:notice] = "destroy the queue item"
    redirect_to my_queue_path 
  end

end
