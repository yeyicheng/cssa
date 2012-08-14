require 'spec_helper'

<<<<<<< HEAD
describe "weathers/index" do
  before(:each) do
    assign(:weathers, [
      stub_model(Weather,
<<<<<<< HEAD
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
=======
        :time => "Time",
        :condition => "Condition",
        :temp_c => "9.99",
        :temp_f => "9.99",
        :icon_url => "Icon Url"
      ),
      stub_model(Weather,
        :time => "Time",
        :condition => "Condition",
        :temp_c => "9.99",
        :temp_f => "9.99",
        :icon_url => "Icon Url"
>>>>>>> master
      )
    ])
  end

  it "renders a list of weathers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
<<<<<<< HEAD
=======
    assert_select "tr>td", :text => "Time".to_s, :count => 2
>>>>>>> master
    assert_select "tr>td", :text => "Condition".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Icon Url".to_s, :count => 2
<<<<<<< HEAD
    assert_select "tr>td", :text => "Location".to_s, :count => 2
=======
>>>>>>> master
  end
=======
describe "weathers/index.html.erb" do
  pending "add some examples to (or delete) #{__FILE__}"
>>>>>>> old2
end
