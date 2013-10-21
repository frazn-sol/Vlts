require 'test_helper'

class ContactPeopleControllerTest < ActionController::TestCase
  setup do
    @contact_person = contact_people(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contact_people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact_person" do
    assert_difference('ContactPerson.count') do
      post :create, contact_person: { address1: @contact_person.address1, address2: @contact_person.address2, city: @contact_person.city, email: @contact_person.email, name: @contact_person.name, password: @contact_person.password, passwordhint: @contact_person.passwordhint, phone1: @contact_person.phone1, phone2: @contact_person.phone2, role: @contact_person.role, state: @contact_person.state, username: @contact_person.username, website: @contact_person.website, zipcode: @contact_person.zipcode }
    end

    assert_redirected_to contact_person_path(assigns(:contact_person))
  end

  test "should show contact_person" do
    get :show, id: @contact_person
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contact_person
    assert_response :success
  end

  test "should update contact_person" do
    put :update, id: @contact_person, contact_person: { address1: @contact_person.address1, address2: @contact_person.address2, city: @contact_person.city, email: @contact_person.email, name: @contact_person.name, password: @contact_person.password, passwordhint: @contact_person.passwordhint, phone1: @contact_person.phone1, phone2: @contact_person.phone2, role: @contact_person.role, state: @contact_person.state, username: @contact_person.username, website: @contact_person.website, zipcode: @contact_person.zipcode }
    assert_redirected_to contact_person_path(assigns(:contact_person))
  end

  test "should destroy contact_person" do
    assert_difference('ContactPerson.count', -1) do
      delete :destroy, id: @contact_person
    end

    assert_redirected_to contact_people_path
  end
end
