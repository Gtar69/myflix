require 'spec_helper'

describe SessionsController do

  describe "GET new" do
    it "render the new template if user not authenticated" do
      get :new
      response.should render_template :new
    end
    it "redirect to video home if user authenticated " do
      session[:user_id] = Fabricate(:user).id
      get :new
      response.should redirect_to home_path
    end    
  end

  describe "POST create" do
    context "with valid credentials" do
      before do 
        @chris = Fabricate(:user)
        post :create, email: @chris.email, password: @chris.password
      end
      
      it "stores sign in user in the session" do
        session[:user_id].should == @chris.id
      end 
      it "redirect to the home path" do 
        response.should redirect_to home_path
      end  
      #it "sets the notice"

    end 

    context "with invalid crendentials" do
      before do
        post :create, email: "chris@example.com", password: "5566"
      end

      it "set notice" do 
        flash[:error].should == "Invalid email or password."
      end
      it "redirect to sign_in path" do 
        response.should redirect_to sign_in_path
      end
    end
    

  end

  describe "GET sign_out" do 
    it "destroy the session after sign out" do
      session[:user_id] = Fabricate(:user).id
      get :destroy
      session[:user_id].should == nil
    end  
    it "redirect to front page after sign out" do 
      session[:user_id] = Fabricate(:user).id
      get :destroy
      response.should redirect_to root_path
    end
  end

end
