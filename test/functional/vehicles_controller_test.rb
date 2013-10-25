require 'test_helper'

class VehiclesControllerTest < ActionController::TestCase
  setup do
    @vehicle = vehicles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vehicles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vehicle" do
    assert_difference('Vehicle.count') do
      post :create, vehicle: { badge_number: @vehicle.badge_number, driver_first_name: @vehicle.driver_first_name, driver_last_name: @vehicle.driver_last_name, driver_middle_name: @vehicle.driver_middle_name, expiry_date: @vehicle.expiry_date, permit_date: @vehicle.permit_date, platenumber: @vehicle.platenumber, visitor: @vehicle.visitor }
    end

    assert_redirected_to vehicle_path(assigns(:vehicle))
  end

  test "should show vehicle" do
    get :show, id: @vehicle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vehicle
    assert_response :success
  end

  test "should update vehicle" do
    put :update, id: @vehicle, vehicle: { badge_number: @vehicle.badge_number, driver_first_name: @vehicle.driver_first_name, driver_last_name: @vehicle.driver_last_name, driver_middle_name: @vehicle.driver_middle_name, expiry_date: @vehicle.expiry_date, permit_date: @vehicle.permit_date, platenumber: @vehicle.platenumber, visitor: @vehicle.visitor }
    assert_redirected_to vehicle_path(assigns(:vehicle))
  end

  test "should destroy vehicle" do
    assert_difference('Vehicle.count', -1) do
      delete :destroy, id: @vehicle
    end

    assert_redirected_to vehicles_path
  end
end
