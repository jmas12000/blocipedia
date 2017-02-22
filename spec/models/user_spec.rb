require 'rails_helper'

RSpec.describe User, type: :model do
  
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to allow_value("user@bloccit.com").for(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe User do
    before :each do
      @user = build(:user)
    end
     it "should have password and email attributes" do
      expect(@user).to have_attributes(password: @user.password, email: @user.email)
    end
    
    it "should be valid with a password length" do
      @user.password = '123456'
     expect(@user).to be_valid
    end
  end
end