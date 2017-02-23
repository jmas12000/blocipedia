require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
 
  describe "GET #index" do
    before do
      allow(controller).to receive(:authenticate_user!).and_return(true)
    end 
    
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #about" do
    before do
      allow(controller).to receive(:authenticate_user!).and_return(true)
    end 
    
    it "renders the about template" do
      get :about
      expect(response).to render_template("about")
    end
  end

end
