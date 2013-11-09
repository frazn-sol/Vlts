class CustomerContactsController < ApplicationController
  before_filter :authenticate_user!
  # GET /customer_contacts
  # GET /customer_contacts.json
  def index
    if current_user.role == ("admin" || "support")
      @customer_contacts = CustomerContact.paginate(:page => params[:page], :per_page => 5)
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @customer_contacts }
      end
    else
      redirect_to error_users_path and return
    end 
  end

  # GET /customer_contacts/1
  # GET /customer_contacts/1.json
  def show
    if current_user.role == ("admin" || "support")
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
    if current_user.role == ("admin" || "support")
    
      @customer_contact = CustomerContact.new
      @customer = current_user
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @customer_contact }
      end
    else
      redirect_to error_users_path and return
    end  
  end

  # GET /customer_contacts/1/edit
  def edit
    if current_user.role == ("admin" || "support")
    
      @customer_contact = CustomerContact.find(params[:id])
    else
      redirect_to error_users_path and return
    end  
  end

  # POST /customer_contacts
  # POST /customer_contacts.json
  def create
    @customer_contact = CustomerContact.new(params[:customer_contact])

    respond_to do |format|
      if @customer_contact.save
        format.html { redirect_to @customer_contact, notice: 'Customer contact was successfully created.' }
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
        format.html { redirect_to @customer_contact, notice: 'Customer contact was successfully updated.' }
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
    if current_user.role == ("admin" || "support")
      @customer_contact = CustomerContact.find(params[:id])
      @customer_contact.destroy

      respond_to do |format|
        format.html { redirect_to customer_contacts_url }
        format.json { head :no_content }
      end
    else
      redirect_to error_users_path and return
    end
  end
end
