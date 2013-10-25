require 'test_helper'

class OrganizationContactsControllerTest < ActionController::TestCase
  setup do
    @organization_contact = organization_contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organization_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create organization_contact" do
    assert_difference('OrganizationContact.count') do
      post :create, organization_contact: { cell: @organization_contact.cell, designation: @organization_contact.designation, email: @organization_contact.email, first_name: @organization_contact.first_name, last_name: @organization_contact.last_name, middle_name: @organization_contact.middle_name, phone: @organization_contact.phone }
    end

    assert_redirected_to organization_contact_path(assigns(:organization_contact))
  end

  test "should show organization_contact" do
    get :show, id: @organization_contact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @organization_contact
    assert_response :success
  end

  test "should update organization_contact" do
    put :update, id: @organization_contact, organization_contact: { cell: @organization_contact.cell, designation: @organization_contact.designation, email: @organization_contact.email, first_name: @organization_contact.first_name, last_name: @organization_contact.last_name, middle_name: @organization_contact.middle_name, phone: @organization_contact.phone }
    assert_redirected_to organization_contact_path(assigns(:organization_contact))
  end

  test "should destroy organization_contact" do
    assert_difference('OrganizationContact.count', -1) do
      delete :destroy, id: @organization_contact
    end

    assert_redirected_to organization_contacts_path
  end
end
