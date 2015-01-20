require 'spec_helper'

describe VideosController do
  
  describe "GET show" do
    it "set the @video variable" do
      family_guy = Video.create(title: "family guy", description: "funny funny")
      south_park = Video.create(title: "south park", description: "south park" )
      get :show, id: south_park.id
      assigns(:video).should == south_park 
    end

    it "render the show template" do
      family_guy = Video.create(title: "family guy", description: "funny funny")
      south_park = Video.create(title: "south park", description: "south park" )
      get :show, id: south_park.id 
      response.should render_template :show
    end
    
  end
  
  describe "GET search" do
    it "set the @videos variable" do
      family_guy = Video.create(title: "family guy", description: "funny funny")
      south_park = Video.create(title: "south park", description: "south park" )
      family_guy_2 = Video.create(title: "family guy 2", description: "funny funny")
      south_park_2 = Video.create(title: "south park 2", description: "south park" )
      family_guy_3 = Video.create(title: "family guy 3", description: "funny funny")
      south_park_3 = Video.create(title: "south park 3", description: "south park" )
      get :search, search: "family"
      assigns(:videos).should == [family_guy, family_guy_2, family_guy_3]

    end
    
    it "render the search template" do
      get :search, search: "family"
      response.should render_template :search
    end
  end

end
