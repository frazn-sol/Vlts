class CustomersController < ApplicationController
  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
    
    respond_to do |format|
      format.html {render layout: "custom"}
      format.json { render json: @customers }
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = Customer.find(params[:id])

    respond_to do |format|
      format.html {render layout: "custom"}
      format.json { render json: @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.json
  def new
    @customer = Customer.new

    respond_to do |format|
      format.html {render layout: "custom"}
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
    @customer = Customer.new(params[:customer])

    respond_to do |format|
      if @customer.save
        # if (session[:flag]==true)
          flash[:notice] = "Customer has been created successfully"
          # session[:flag] = false
          redirect_to admins_path and return
        # # end
        # flash[:notice] = 'Customer was successfully created.'
        # redirect_to customers_path and return
      else
        format.html { render action: "new" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.json
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        # if (session[:flag]==true)
          flash[:notice] = "Customer has been updated successfully"
          # session[:flag] = false
          redirect_to admins_path and return
        # end
        # format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        # format.json { head :no_content }
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
    # if (session[:flag]==true)
          flash[:notice] = "Customer has been deleted successfully"
          # session[:flag] = false
          redirect_to admins_path and return
        # end
    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end

 
end
