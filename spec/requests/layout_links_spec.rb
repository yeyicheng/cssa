require 'spec_helper'

describe "LayoutLinks" do
  
  describe "GET /layout_links" do
    it "should have a Home page at '/'" do
		get '/'
		response.should have_selector('title', :content => "Home")
	end
	it "should have a Clubs page at '/club'" do
		get '/club'
		response.should have_selector('title', :content => "Clubs")
	end
	it "should have an About page at '/contact'" do
		get '/contact'
		response.should have_selector('title', :content => "Contact")
	end
	it "should have an Contact page at '/about'" do
		get '/about'
		response.should have_selector('title', :content => "About")
	end
  end
  
end
