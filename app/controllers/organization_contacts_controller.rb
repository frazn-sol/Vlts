class OrganizationContactsController < ApplicationController
  before_filter :authenticate_user!
  # GET /organization_contacts
  # GET /organization_contacts.json
  def index
    @organization_contacts = OrganizationContact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organization_contacts }
    end
  end

  # GET /organization_contacts/1
  # GET /organization_contacts/1.json
  def show
    @organization_contact = OrganizationContact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organization_contact }
    end
  end

  # GET /organization_contacts/new
  # GET /organization_contacts/new.json
  def new
    @organization_contact = OrganizationContact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organization_contact }
    end
  end

  # GET /organization_contacts/1/edit
  def edit
    @organization_contact = OrganizationContact.find(params[:id])
  end

  # POST /organization_contacts
  # POST /organization_contacts.json
  def create
    @organization_contact = OrganizationContact.new(params[:organization_contact])

    respond_to do |format|
      if @organization_contact.save
        format.html { redirect_to @organization_contact, notice: 'Organization contact was successfully created.' }
        format.json { render json: @organization_contact, status: :created, location: @organization_contact }
      else
        format.html { render action: "new" }
        format.json { render json: @organization_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /organization_contacts/1
  # PUT /organization_contacts/1.json
  def update
    @organization_contact = OrganizationContact.find(params[:id])

    respond_to do |format|
      if @organization_contact.update_attributes(params[:organization_contact])
        format.html { redirect_to @organization_contact, notice: 'Organization contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @organization_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organization_contacts/1
  # DELETE /organization_contacts/1.json
  def destroy
    @organization_contact = OrganizationContact.find(params[:id])
    @organization_contact.destroy

    respond_to do |format|
      format.html { redirect_to organization_contacts_url }
      format.json { head :no_content }
    end
  end
end
