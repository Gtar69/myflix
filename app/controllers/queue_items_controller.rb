class QueueItemsController < ApplicationController
  before_filter :require_user
 
  def index
    @queue_items = current_user.queue_items#.order(order: :asc)
  end

  def create
    video = Video.find(params[:video_id]) 
    queue_video(video)
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy! if current_user.queue_items.include?(queue_item)
    flash[:info] = "destroy the queue item"
    normalize_queue_item_position
    redirect_to my_queue_path 
  end

  def update_queue
    begin
      update_queue_items
      normalize_queue_item_position
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Invalid position numbers."
      redirect_to my_queue_path
      return
    end
    redirect_to my_queue_path
  end


  private

  def queue_video(video)
    QueueItem.create(video: video, user: current_user, position: 
      new_queue_item_position) unless current_video_queued_video?(video)    
  end

  def new_queue_item_position
    current_user.queue_items.count + 1
  end

  def current_video_queued_video?(video)
    current_user.queue_items.map{|q| q.video}.include?(video)
  end

  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data[:id])
        queue_item.update_attributes!(position: queue_item_data[:position], rating: queue_item_data[:rating]) if queue_item.user == current_user
      end
    end
  end

  def normalize_queue_item_position
    current_user.queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index+1)
    end
  end

end
