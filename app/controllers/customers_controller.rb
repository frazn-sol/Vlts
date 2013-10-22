class CustomersController < ApplicationController
  before_filter :authenticate_user!
  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
    @user = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customers }
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = Customer.find(params[:id])
    @user = User.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.json
  def new
    @customer = Customer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
  end

  # POST /customers
  # POST /customers.json
  def create
    a = params[:customer][:user]
    params[:customer].delete(:user)
    @customer = Customer.new(params[:customer])

    @user = User.new
    @user.email = a[:email]
    @user.password = a[:password]
    @user.passwordhint = a[:passwordhint]
    @user.role = "customer"
    @user.save
    if @user.save
      respond_to do |format|
        @customer.user_id = current_user.id
        if @customer.save
          @user.update_attribute(:customer_id, @customer.id)
          binding.pry
          format.html { redirect_to users_path, notice: 'Customer was successfully created.' }
          format.json { render json: @customer, status: :created, location: @customer }
        else
          format.html { render action: "new" }
          format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
      end
    else
      if (@user.errors.messages.first[0] == :email)
        flash[:notice] = "Email " + (@user.errors.messages.first[1]).to_sentence
      elsif 
        flash[:notice] = "Password " + (@user.errors.messages.first[1]).to_sentence  
      end          
      respond_to do |format|
        format.html { render action: "new" }
      end
    end  
  end

  # PUT /customers/1
  # PUT /customers/1.json
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to users_path, notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end
end
