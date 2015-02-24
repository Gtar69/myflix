require 'spec_helper'

describe RelationshipsController do

  describe "GET index" do 
    it "sets @relationships to the current user folowing relationships" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: alice, leader: bob)
      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end

    it_behaves_like "requires sign in" do
      let(:action) {get :index}
    end 

  end

  describe "POST create" do 
    it_behaves_like "requires sign in" do 
      let(:action) {post :create, leader_id: 3}
    end
    
    it "redirect to user page" do 
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      post :create, leader_id: bob.id
      expect(response).to redirect_to people_path
    end
    
    it "creates the relationship between user and follower" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      post :create, leader_id: bob.id
      expect(Relationship.count).to eq(1)
    end

    it "does not create the relationship if current user has already followed user" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      Relationship.create(leader: bob, follower: alice)
      post :create, leader_id: bob.id
      expect(Relationship.count).to eq(1)
    end

    it "does not create the relationship if user follow himself" do 
      alice = Fabricate(:user)
      set_current_user(alice)
      post :create, leader_id: alice.id
      expect(Relationship.count).to eq(0)
    end

  end



  describe "DELETE destroy" do
    it_behaves_like "requires sign in" do
      let(:action) {delete :destroy, id: 4}
    end

    it "redirects to the people page" do 
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: alice, leader: bob)
      delete :destroy, id: relationship.id
      expect(response).to redirect_to people_path
    end

    it "deletes the relationship if the current user is the follower" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: alice, leader: bob)
      delete :destroy, id: relationship.id
      expect(Relationship.count).to eq(0)
    end
    #prevent malicious user
    it "does not delete the relationship if the current user if not the follower" do
      charlie = Fabricate(:user)
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: charlie, leader: bob)
      delete :destroy, id: relationship.id
      expect(Relationship.count).to eq(1)
    end
  
  end

end
