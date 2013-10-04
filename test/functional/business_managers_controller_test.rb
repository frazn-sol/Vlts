require 'test_helper'

class BusinessManagersControllerTest < ActionController::TestCase
  setup do
    @business_manager = business_managers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:business_managers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create business_manager" do
    assert_difference('BusinessManager.count') do
      post :create, business_manager: { address1: @business_manager.address1, address2: @business_manager.address2, city: @business_manager.city, email: @business_manager.email, name: @business_manager.name, password: @business_manager.password, passwordhint: @business_manager.passwordhint, phone1: @business_manager.phone1, phone2: @business_manager.phone2, role: @business_manager.role, state: @business_manager.state, username: @business_manager.username, website: @business_manager.website, zipcode: @business_manager.zipcode }
    end

    assert_redirected_to business_manager_path(assigns(:business_manager))
  end

  test "should show business_manager" do
    get :show, id: @business_manager
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @business_manager
    assert_response :success
  end

  test "should update business_manager" do
    put :update, id: @business_manager, business_manager: { address1: @business_manager.address1, address2: @business_manager.address2, city: @business_manager.city, email: @business_manager.email, name: @business_manager.name, password: @business_manager.password, passwordhint: @business_manager.passwordhint, phone1: @business_manager.phone1, phone2: @business_manager.phone2, role: @business_manager.role, state: @business_manager.state, username: @business_manager.username, website: @business_manager.website, zipcode: @business_manager.zipcode }
    assert_redirected_to business_manager_path(assigns(:business_manager))
  end

  test "should destroy business_manager" do
    assert_difference('BusinessManager.count', -1) do
      delete :destroy, id: @business_manager
    end

    assert_redirected_to business_managers_path
  end
end
