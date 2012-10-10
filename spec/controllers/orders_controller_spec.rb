require 'spec_helper'

describe OrdersController do

  it "should give a list of orders on index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

end
