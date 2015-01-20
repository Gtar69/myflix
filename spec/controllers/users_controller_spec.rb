require 'spec_helper'

describe UsersController do
  #authentication path user#new/sign_up
  #let(:user) {Fabricate.build(:user)}
  describe "GET new" do
    it "set @user" do
      get :new
      assigns(:user).should be_instance_of(User)
    end

  end 
  
  describe "POST create" do
    context "with valid input" do
      before do 
        post :create, user: Fabricate.attributes_for(:user) 
      end

      it "can save an object via correct params" do
        User.count.should == 1
      end
      
      it "redirect to sign_in page after successful create" do
        response.should redirect_to sign_in_path
      end
    end

    context "with invalid input" do
      before do
        post :create, user: {email: "chris@example.com", password: "12345"}
      end

      it "does not create the user" do
        User.count.should == 0
      end
      
      it "render new page after not succesful create" do
        response.should render_template :new
      end
      
      it "set @user" do 
        assigns(:user).should be_instance_of(User)
      end
    end

  end

end
