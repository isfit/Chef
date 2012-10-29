require 'spec_helper'

describe "meal_types/show" do
  before(:each) do
    @meal_type = assign(:meal_type, stub_model(MealType))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
