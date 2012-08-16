# require 'rubygems'
# require 'rufus/scheduler'
# #require other classes which you want to use. Example any model or helper class which has implementation of required task

scheduler = Rufus::Scheduler.start_new
 
def updateWeather
	w = SimpleWeather::Weather.new
	attr = w.updateWeather
	weather = Weather.new(attr)
	weather.save
end
 
# updateWeather
 
scheduler.every("30m") do
	updateWeather
end
