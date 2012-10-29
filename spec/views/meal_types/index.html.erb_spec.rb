require 'spec_helper'

describe "meal_types/index" do
  before(:each) do
    assign(:meal_types, [
      stub_model(MealType),
      stub_model(MealType)
    ])
  end

  it "renders a list of meal_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
