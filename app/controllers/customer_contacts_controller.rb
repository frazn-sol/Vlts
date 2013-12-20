class CustomerContactsController < ApplicationController
  before_filter :authenticate_user!
  
    # GET /customer_contacts
  # GET /customer_contacts.json
  def index
    if (current_user.role == "admin" || current_user.role == "support")
      if params[:customer_id].present?
        add_breadcrumb 'Customers', 'customers_path'
        add_breadcrumb "#{Customer.where(:id => params[:customer_id])[0].company_name}", '#'  
        add_breadcrumb "Contacts", 'customer_contacts_path(:customer_id => "#{params[:customer_id]}")'
        
        @customer_contacts = CustomerContact.where(:customer_id => "#{params[:customer_id]}", :delflag => false).paginate(:page => params[:page], :per_page => 5)
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @customer_contacts }
        end
      else
        @customer_contacts = CustomerContact.paginate(:page => params[:page], :per_page => 5)
        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @customer_contacts }
          end
        end
      else
        redirect_to error_users_path and return
      end
    end

  # GET /customer_contacts/1
  # GET /customer_contacts/1.json
  def show
    add_breadcrumb 'Customers', 'customers_path'
    add_breadcrumb "#{Customer.where(:id => params[:customer_id])[0].company_name}", '#'
    add_breadcrumb "Contacts", 'customer_contacts_path(:customer_id => "#{params[:customer_id]}")'
    add_breadcrumb 'View Customer Contacts', 'customer_contact_path'
    if (current_user.role == "admin" || current_user.role == "support")
      @customer_contact = CustomerContact.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @customer_contact }
      end
    else
      redirect_to error_users_path and return
    end  
  end

  # GET /customer_contacts/new
  # GET /customer_contacts/new.json
  def new
    if (current_user.role == "admin" || current_user.role == "support")
      if params[:customer_id].present?
        add_breadcrumb 'Customers', 'customers_path'
        add_breadcrumb "#{Customer.where(:id => params[:customer_id])[0].company_name}", '#'
        add_breadcrumb "Contacts", 'customer_contacts_path(:customer_id => "#{params[:customer_id]}")'
        add_breadcrumb 'New Customer Contact', 'new_customer_contact_path'
        
        @customer_contact = CustomerContact.new
        @customer = current_user
        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @customer_contact }
        end
      else
        @customer_contact = CustomerContact.new
        @customer = current_user
        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @customer_contact }
        end
      end  
    else
      redirect_to error_users_path and return
    end  
  end

  # GET /customer_contacts/1/edit
  def edit
    add_breadcrumb 'Customers', 'customers_path'
    add_breadcrumb "#{Customer.where(:id => params[:customer_id])[0].company_name}", '#'
    add_breadcrumb "Contacts", 'customer_contacts_path(:customer_id => "#{params[:customer_id]}")'
    add_breadcrumb 'Update Customer Conatct', 'edit_customer_contact_path'
    if (current_user.role == "admin" || current_user.role == "support")
      
      @customer_contact = CustomerContact.find(params[:id])
    else
      redirect_to error_users_path and return
    end  
  end

  # POST /customer_contacts
  # POST /customer_contacts.json
  def create
    @customer_contact = CustomerContact.new(params[:customer_contact])
    if params[:id][:customer_id].empty?
      @customer_contact.customer_id = params[:customer_contact][:customer_id]
    else
      @customer_contact.customer_id = params[:id][:customer_id]
    end  
    respond_to do |format|
      if @customer_contact.save && params[:id][:customer_id].present?
        format.html { redirect_to customer_contacts_path(:customer_id => params[:id][:customer_id]), notice: 'Customer contact was successfully created.' }
        format.json { render json: @customer_contact, status: :created, location: @customer_contact }
      elsif @customer_contact.save
        format.html { redirect_to customers_path, notice: 'Customer contact was successfully created.' }
        format.json { render json: @customer_contact, status: :created, location: @customer_contact }
      else
        format.html { render action: "new" }
        format.json { render json: @customer_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customer_contacts/1
  # PUT /customer_contacts/1.json
  def update
    @customer_contact = CustomerContact.find(params[:id])

    respond_to do |format|
      if @customer_contact.update_attributes(params[:customer_contact])
        format.html { redirect_to customer_contacts_path(:customer_id => params[:id][:customer_id]), notice: 'Customer contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_contacts/1
  # DELETE /customer_contacts/1.json
  def destroy
    if (current_user.role == "admin" || current_user.role == "support")
      @customer_contact = CustomerContact.find(params[:id])
      @action = request.referrer
      @customer_contact.delflag = true
      if @customer_contact.update_attributes(params[:customer_contact])
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
