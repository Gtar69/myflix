require 'spec_helper'

describe VideosController do
  
  describe "GET show" do
    before do
      session[:user_id] = Fabricate(:user).id
      @video = Fabricate(:video)
    end

    it "sets the @video variable" do
      get :show, id: @video.id
      assigns(:video).should == @video 
    end

    it "set the @reviews variables" do
      review1 = Fabricate(:review, video: @video)
      review2 = Fabricate(:review, video: @video)
      get :show, id: @video.id
      assigns(:reviews).should =~ [review2, review1]
    end

    it "render the show template" do
      get :show, id: @video.id 
      response.should render_template :show
    end
    
  end
  
  describe "GET search" do
    before do
      session[:user_id] = Fabricate(:user).id
      6.times { Fabricate(:video)}
      @video = Fabricate(:video)
    end

    it "set the @videos variable" do
      get :search, search: @video.title
      assigns(:videos).should == [@video]
    end
    
    it "render the search template" do
      get :search, search: "family"
      response.should render_template :search
    end
  end

  describe "POST #add_to_queue" do
    before do
      @user = Fabricate(:user)
      session[:user_id] = @user.id
      6.times { Fabricate(:video)}
      @video = Fabricate(:video)
      post :add_to_queue, id: @video.id
    end

    it "can add video to user queue" do
      @user.videos.should include(@video)
    end
    it "render queue template after succesfull add_to_queue" do
      response.should redirect_to my_queue_path
    end
    
    it "still in video page after failed add_to_queue"

  end


end
