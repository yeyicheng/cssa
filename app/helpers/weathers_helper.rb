module WeathersHelper
	def getLatestWeatherIcon
		w = Weather.all.first
		image_tag('http://www.google.com' << w.icon_url, size: '50x50', class: 'weather_icon round')
	end
	
	def getLatestWeatherCondition
		w = Weather.all.first
		w.condition
	end
	
	def getLatestTemp
		w = Weather.all.first
		w.temp_c.to_s << ' C/ ' << w.temp_f.to_s << ' F' 
	end
end
