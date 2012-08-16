class AddWeatherTimeIndex < ActiveRecord::Migration
  def up
  	  add_index :weathers, :time, unique: true
  end

  def down
  	  remove_index :weathers, :time
  end
end
