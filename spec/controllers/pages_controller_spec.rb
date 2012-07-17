require 'spec_helper'

describe PagesController do
  render_views
  
  describe "GET 'home'" do
    it "returns http success" do
		get 'home'
		response.should be_success
    end
    
    it "should have the right title" do
		get 'home'
		response.should have_selector("title", :content => "Chinese Student and Scholar Association of UMCP | Home")
	end
  end
  
  describe "GET 'club'" do
    it "returns http success" do
		get 'club'
		response.should be_success
    end
    
    it "should have the right title" do
		get 'club'
		response.should have_selector("title", :content => "Chinese Student and Scholar Association of UMCP | Clubs")
	end
  end

end
