require 'spec_helper'

describe "weathers/show" do
  before(:each) do
    @weather = assign(:weather, stub_model(Weather,
      :time => "Time",
      :condition => "Condition",
      :temp_c => "9.99",
      :temp_f => "9.99",
      :icon_url => "Icon Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Time/)
    rendered.should match(/Condition/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/Icon Url/)
  end
end
