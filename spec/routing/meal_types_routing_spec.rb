require "spec_helper"

describe MealTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/meal_types").should route_to("meal_types#index")
    end

    it "routes to #new" do
      get("/meal_types/new").should route_to("meal_types#new")
    end

    it "routes to #show" do
      get("/meal_types/1").should route_to("meal_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/meal_types/1/edit").should route_to("meal_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/meal_types").should route_to("meal_types#create")
    end

    it "routes to #update" do
      put("/meal_types/1").should route_to("meal_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/meal_types/1").should route_to("meal_types#destroy", :id => "1")
    end

  end
end
