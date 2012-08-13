
module PagesHelper
	
	def show_weather
		# @w = {}
		# updateWeather
		
		updateWeather

		image_tag(getImageUrl(), alt: '', size: "64x64", class: 'simple_weather')
		
		# image_tag(getImageUrl(@w), alt: getWeather(@w), size: "64x64", class: 'simple_weather')
		# outputs << image_tag(getImageUrl(@w), alt: getWeather(@w), size: "64x64", class: 'simple_weather')
		# outputs << "#{getTemp_c(@w)} C / #{getTemp_f(@w)} F"
		# outputs << getFeelsLike(@w)
		# outputs
	end      
end
