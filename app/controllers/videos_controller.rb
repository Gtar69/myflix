class VideosController < ApplicationController
  before_filter :require_user

  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    @reviews = Review.where(video_id: params[:id])
    @average = @video.avg_rating
  end

  def search
    @videos = Video.search_by_title(params[:search])
  end

  def add_to_queue
    @video = Video.find(params[:id])
    if !current_user.videos.include?(@video)
      current_user.add_video_to_queue(@video, current_user)
      redirect_to my_queue_path
    else
      flash[:error] = "You already have the video in your queues"
    end
  end


end
