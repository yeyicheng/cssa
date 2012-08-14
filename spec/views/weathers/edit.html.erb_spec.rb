require 'spec_helper'

describe "weathers/edit" do
  before(:each) do
    @weather = assign(:weather, stub_model(Weather,
<<<<<<< HEAD
      :condition => "MyString",
      :temp_c => "9.99",
      :temp_f => "9.99",
      :icon_url => "MyString",
      :location => "MyString"
=======
      :time => "MyString",
      :condition => "MyString",
      :temp_c => "9.99",
      :temp_f => "9.99",
      :icon_url => "MyString"
>>>>>>> master
    ))
  end

  it "renders the edit weather form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => weathers_path(@weather), :method => "post" do
<<<<<<< HEAD
=======
      assert_select "input#weather_time", :name => "weather[time]"
>>>>>>> master
      assert_select "input#weather_condition", :name => "weather[condition]"
      assert_select "input#weather_temp_c", :name => "weather[temp_c]"
      assert_select "input#weather_temp_f", :name => "weather[temp_f]"
      assert_select "input#weather_icon_url", :name => "weather[icon_url]"
<<<<<<< HEAD
      assert_select "input#weather_location", :name => "weather[location]"
=======
>>>>>>> master
    end
  end
end
