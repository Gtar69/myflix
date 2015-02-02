require 'spec_helper'

describe QueueItemsController do

  describe "GET index" do 
    it "sets @queue_items to the queue items for logged user" do
      alice = Fabricate(:user)
      set_current_user(alice)
      queue_item1 = Fabricate(:queue_item, user: alice)
      queue_item2 = Fabricate(:queue_item, user: alice)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it_behaves_like "requires sign in" do 
      let(:action) { get :index }
    end

  end

  describe "POST create" do

    it "redirects to the my queue page" do 
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end
    
    it "creates a queue item" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end

    it "creates the queue item that is associated with the video" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "creates the queue item that is associated with current user" do
      alice = Fabricate(:user)
      set_current_user(alice)
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(alice)
    end

    it "puts the video as the last one in the queue" do 
      alice = Fabricate(:user)
      set_current_user(alice)
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: alice)
      south_park = Fabricate(:video)
      post :create, video_id: south_park.id
      south_park_queue_item= QueueItem.where(video_id: south_park.id,
        user_id: alice.id).first
      expect(south_park_queue_item.position).to eq(2)
    end
    
    it "does not add the video the queue if the video already in the queue" do
      alice = Fabricate(:user)
      set_current_user(alice)
      video = Fabricate(:video)
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: alice)
      post :create, video_id: monk.id
      expect(alice.queue_items.count).to eq(1)
    end

    it_behaves_like "requires sign in" do 
      let(:action) { post :create, video_id: 3 }
    end

  end

  describe "DELETE destroy" do
    it "rediret to my_queue page" do
      set_current_user
      delete :destroy, id: Fabricate(:queue_item).id
      expect(response).to redirect_to my_queue_path
    end 
    it "deletes the queue item" do
      alice = Fabricate(:user)
      set_current_user(alice)
      delete :destroy, id: Fabricate(:queue_item).id
      expect(alice.queue_items.count).to eq(0)
    end
    it "does not delete the queue item if the queue item is not in the current use
      r's queue" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      set_current_user(alice)
      queue_item = Fabricate(:queue_item, user: bob)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end
    
    it_behaves_like "requires sign in" do
      let(:action) { post :create, video_id: 3}
    end
    
    it "normalizes the remaing queue items" do 
      alice = Fabricate(:user)
      set_current_user(alice)
      queue_item1 = Fabricate(:queue_item, user: alice, position: 1)
      queue_item2 = Fabricate(:queue_item, user: alice, position: 2)
      delete :destroy, id: queue_item1.id
      expect(QueueItem.first.position).to eq(1)
    end


  end

  describe "POST update_queue" do
    it_behaves_like "requires sign in" do 
      let(:action) { post :update_queue, queue_items: [{id: 2, position: 3}, 
        {id: 3, position: 2}] }
    end

    context "with valid input" do
      let(:alice) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: alice, position: 1, video: video)}
      let(:queue_item2) { Fabricate(:queue_item, user: alice, position: 2, video: video)}

      before { set_current_user(alice) }
      
      it "redirect to my_queue page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, 
          {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end

      it "reorder the queue item" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, 
          {id: queue_item2.id, position: 1}]
        expect(alice.queue_items).to eq([queue_item2, queue_item1])
      end
      
      it "normalizes the position numbers" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, 
          {id: queue_item2.id, position: 2}]
        expect(alice.queue_items.map(&:position)).to eq([1,2])
      end


    end

    context "with invalid input" do
      let(:alice) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: alice, position: 1, video: video)}
      let(:queue_item2) { Fabricate(:queue_item, user: alice, position: 2, video: video)}

      before { set_current_user(alice) }

      it "redirect to the my queue page" do 
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.3}, 
          {id: queue_item2.id, position: 2.2}]
        expect(response).to redirect_to my_queue_path

      end
      
      it "sets the flash error message" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.3}, 
          {id: queue_item2.id, position: 2.2}]
        expect(flash[:error]).to be_present
      end
      
      it "does not change the queue items" do 
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, 
          {id: queue_item2.id, position: 2.2}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end

    

    context "with queue_item that do not belong to the current user" do
      it "does not change the queue items" do
        alice = Fabricate(:user)
        set_current_user(alice)
        bob = Fabricate(:user)
        queue_item1 = Fabricate(:queue_item, user: bob, position: 1)
        queue_item2 = Fabricate(:queue_item, user: bob, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, 
          {id: queue_item2.id, position: 2}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end 
  
  end


end
