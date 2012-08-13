require 'rubygems'
require 'rufus/scheduler'
#require other classes which you want to use. Example any model or helper class which has implementation of required task
 
scheduler = Rufus::Scheduler.start_new

def updateWeather
	w = SimpleWeather::Weather.new
	attr = w.updateWeather		
	@weather = Weather.create(attr)
end

updateWeather

scheduler.every("20m") do
	updateWeather
end
 