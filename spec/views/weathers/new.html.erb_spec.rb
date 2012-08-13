require 'spec_helper'

describe "weathers/new" do
  before(:each) do
    assign(:weather, stub_model(Weather,
      :time => "MyString",
      :condition => "MyString",
      :temp_c => "9.99",
      :temp_f => "9.99",
      :icon_url => "MyString"
    ).as_new_record)
  end

  it "renders new weather form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => weathers_path, :method => "post" do
      assert_select "input#weather_time", :name => "weather[time]"
      assert_select "input#weather_condition", :name => "weather[condition]"
      assert_select "input#weather_temp_c", :name => "weather[temp_c]"
      assert_select "input#weather_temp_f", :name => "weather[temp_f]"
      assert_select "input#weather_icon_url", :name => "weather[icon_url]"
    end
  end
end
