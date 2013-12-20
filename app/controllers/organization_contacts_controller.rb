class OrganizationContactsController < ApplicationController
  before_filter :authenticate_user!
  # GET /organization_contacts
  # GET /organization_contacts.json
  def index
    if (current_user.role == "customer" || current_user.role == "supervisor")
      if params[:org_id].present?
        add_breadcrumb 'Organizations', 'organizations_path'
        add_breadcrumb "#{Organization.where(:id => params[:org_id])[0].company_name}", '#'  
        add_breadcrumb "Contacts", 'organization_contacts_path(:org_id => "#{params[:org_id]}")'
        @organization_contacts = OrganizationContact.where(:delflag => false, :organization_id => "#{params[:org_id]}").paginate(:page => params[:page], :per_page => 5)

        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @organization_contacts }
        end
      else
        @organization_contacts = OrganizationContact.paginate(:page => params[:page], :per_page => 5)

        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @organization_contacts }
        end
      end  
    else
      redirect_to error_users_path and return
    end
  end

  # GET /organization_contacts/1
  # GET /organization_contacts/1.json
  def show
    if (current_user.role == "customer" || current_user.role == "supervisor")
      add_breadcrumb 'Organizations', 'organizations_path'
      add_breadcrumb "#{Organization.where(:id => params[:org_id])[0].company_name}", '#'  
      add_breadcrumb "Contacts", 'organization_contacts_path(:org_id => "#{params[:org_id]}")'
      add_breadcrumb "View Contacts", 'organization_contacts_path'
      @organization_contact = OrganizationContact.find(params[:id])

      respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organization_contact }
    end
  else
    redirect_to error_users_path and return
  end
end

  # GET /organization_contacts/new
  # GET /organization_contacts/new.json
  def new
    if (current_user.role == "customer" || current_user.role == "supervisor")
      if params[:org_id].present?
        add_breadcrumb 'Organizations', 'organizations_path'
        add_breadcrumb "#{Organization.where(:id => params[:org_id])[0].company_name}", '#'  
        add_breadcrumb "Contacts", 'organization_contacts_path(:org_id => "#{params[:org_id]}")'

        add_breadcrumb 'New Organization Contact', 'new_organization_contact_path'

        @organization_contact = OrganizationContact.new

        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @organization_contact }
        end
      else
        @organization_contact = OrganizationContact.new

        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @organization_contact }
        end
      end    
    else
      redirect_to error_users_path and return
    end
  end

  # GET /organization_contacts/1/edit
  def edit
    if (current_user.role == "customer" || current_user.role == "supervisor")
      add_breadcrumb 'Organizations', 'organizations_path'
      add_breadcrumb "#{Organization.where(:id => params[:org_id])[0].company_name}", '#'  
      add_breadcrumb "Contacts", 'organization_contacts_path(:org_id => "#{params[:org_id]}")'
      add_breadcrumb "Update Contact", "edit_organization_contact_path"
      @organization_contact = OrganizationContact.find(params[:id])
    else
      redirect_to error_users_path and return
    end
  end

  # POST /organization_contacts
  # POST /organization_contacts.json
  def create
    binding.pry
    @organization_contact = OrganizationContact.new(params[:organization_contact])
    if params[:id][:org_id].empty?
      @organization_contact.organization_id = params[:organization_contact][:organization_id]
    else
      @organization_contact.organization_id = params[:id][:org_id]
    end 

    respond_to do |format|
      if @organization_contact.save && params[:id][:org_id].present?
        format.html { redirect_to organization_contacts_path(:org_id => params[:id][:org_id]), notice: 'Organization contact was successfully created.' }
        format.json { render json: @organization_contact, status: :created, location: @customer_contact }
      elsif @organization_contact.save
        format.html { redirect_to organizations_path, notice: 'Organization contact was successfully created.' }
        format.json { render json: @organization_contact, status: :created, location: @customer_contact }
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
        format.html { redirect_to organization_contacts_path(:org_id => params[:id][:org_id]), notice: 'Organization contact was successfully updated.' }
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
    if (current_user.role == "customer" || current_user.role == "supervisor")    
      @organization_contact = OrganizationContact.find(params[:id])
      @action = request.referrer
      @organization_contact.delflag = true
      if @organization_contact.update_attributes(params[:organization_contact])
        flash[:notice] = "Successfully Deleted"
        respond_to do |format|
          format.html { redirect_to @action }
          format.json { head :no_content }
        end
      else
        flash[:notice] = "Could not Deleted"
        respond_to do |format|
          format.html { redirect_to @action }
          format.json { head :no_content }
        end
      end
    else
      redirect_to error_users_path and return
    end
  end
end
