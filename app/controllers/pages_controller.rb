
class PagesController < ApplicationController
  def home
	@title = 'Home'
  end
  
  def club
	@title = 'Clubs'
  end
  
  def contact
	@title = 'Contact'
  end
  
  def about
	@title = 'About'
  end
end
