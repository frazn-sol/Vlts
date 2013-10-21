require 'test_helper'

class PlazasControllerTest < ActionController::TestCase
  setup do
    @plaza = plazas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plazas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plaza" do
    assert_difference('Plaza.count') do
      post :create, plaza: { description: @plaza.description, latitude: @plaza.latitude, location: @plaza.location, longitude: @plaza.longitude, name: @plaza.name }
    end

    assert_redirected_to plaza_path(assigns(:plaza))
  end

  test "should show plaza" do
    get :show, id: @plaza
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plaza
    assert_response :success
  end

  test "should update plaza" do
    put :update, id: @plaza, plaza: { description: @plaza.description, latitude: @plaza.latitude, location: @plaza.location, longitude: @plaza.longitude, name: @plaza.name }
    assert_redirected_to plaza_path(assigns(:plaza))
  end

  test "should destroy plaza" do
    assert_difference('Plaza.count', -1) do
      delete :destroy, id: @plaza
    end

    assert_redirected_to plazas_path
  end
end
