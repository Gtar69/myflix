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

end
