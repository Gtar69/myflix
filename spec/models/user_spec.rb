require 'spec_helper'

describe User do
  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:password)}
  it { should validate_presence_of(:full_name)}
  it { should validate_uniqueness_of(:email)}
  it { should have_many(:queue_items).order(:position)}
  it { should have_many(:reviews)}

  it "generate a random token when the user is created" do
    alice = Fabricate(:user)
    expect(alice.token).to be_present
  end

  describe "#follow" do 
    it "follows another user" do 
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      alice.follow(bob)
      expect(alice.follows?(bob)).to be_truthy
    end
    
    it "does not follow one self" do 
      alice = Fabricate(:user)
      alice.follow(alice)
      expect(alice.follows?(alice)).to be_false
    end
  end


end
