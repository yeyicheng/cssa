module WeathersHelper
	def getLatestWeatherIcon
		w = Weather.first
		link_to image_tag('http://www.google.com' << w.icon_url, size: '50x50', class: 'weather_icon round'), weathers_path
	end

	def getLatestWeatherCondition
		w = Weather.first
		w.condition
	end

	def getLatestTemp
		w = Weather.first
		w.temp_c.to_s << ' C/ ' << w.temp_f.to_s << ' F' 
	end
end
