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

end
