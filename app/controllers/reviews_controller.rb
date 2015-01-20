class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    p params[:id]
    binding.pry
    @review = Review.new(rating: params[:rating].split[0], content: params[:content])
    @review.video_id = params[:video_id]
    @review.user_id = current_user.id
    if @review.save
      redirect_to video_path(params[:video_id].to_i)
    else
      redirect_to video_path(params[:video_id].to_i)
    end
  end

  private

  def review_params
    #params.require(:review).permit(:rating, :review)
  end


end
