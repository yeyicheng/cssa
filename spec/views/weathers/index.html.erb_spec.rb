require 'spec_helper'

describe "weathers/index" do
  before(:each) do
    assign(:weathers, [
      stub_model(Weather,
        :condition => "Condition",
        :temp_c => "9.99",
        :temp_f => "9.99",
        :icon_url => "Icon Url",
        :location => "Location"
      ),
      stub_model(Weather,
        :condition => "Condition",
        :temp_c => "9.99",
        :temp_f => "9.99",
        :icon_url => "Icon Url",
        :location => "Location"
      )
    ])
  end

  it "renders a list of weathers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Condition".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Icon Url".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
  end
end
