require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to allow_value("user@bloccit.com").for(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "User attributes" do
    it "should have password and email attributes" do
      expect(user).to have_attributes(password: user.password, email: user.email)
    end
    
    it "should be valid with a password length" do
      user.password = '123456'
     expect(user).to be_valid
    end
    
    it "responds to role" do
      expect(user).to respond_to(:role)
    end
 
    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end
 
    it "responds to standard?" do
      expect(user).to respond_to(:standard?)
    end
    
    it "responds to premium?" do
      expect(user).to respond_to(:premium?)
    end
  end
  
  describe "roles" do
    it "is standard by default" do
      expect(user.role).to eql("standard")
    end
 
    context "standard user" do
      it "returns true for #standard?" do
        expect(user.standard?).to be_truthy
      end
 
      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
    end
 
    context "admin user" do
      before do
        user.admin!
      end
 
      it "returns false for #standard?" do
        expect(user.standard?).to be_falsey
      end
 
      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end
    end
  end
end