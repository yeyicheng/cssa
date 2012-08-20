module WeathersHelper
	def updateWeather
		w = SimpleWeather::Weather.new
		attr = w.updateWeather
		weather = Weather.new(attr)
		weather.save
	end
	
	def getLatestWeatherIcon
		w = Weather.first
		if !w 
			updateWeather
		end
		link_to image_tag('http://www.google.com' << w.icon_url, size: '50x50', class: 'weather_icon round'), weathers_path
	end

	def getLatestWeatherCondition
		w = Weather.first
		if !w 
			updateWeather
		end
		w.condition
	end

	def getLatestTemp
		w = Weather.first  w = Weather.first
		if !w 
			updateWeather
		end
		w.temp_c.to_s << ' C/ ' << w.temp_f.to_s << ' F' 
	end
end
