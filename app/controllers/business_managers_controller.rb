class BusinessManagersController < ApplicationController
  # GET /business_managers
  # GET /business_managers.json
  def index
    @business_managers = BusinessManager.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @business_managers }
    end
  end

  # GET /business_managers/1
  # GET /business_managers/1.json
  def show
    @business_manager = BusinessManager.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @business_manager }
    end
  end

  # GET /business_managers/new
  # GET /business_managers/new.json
  def new
    @business_manager = BusinessManager.new

    respond_to do |format|
      format.html {render layout: "custom"}# new.html.erb
      format.json { render json: @business_manager }
    end
  end

  # GET /business_managers/1/edit
  def edit
    @business_manager = BusinessManager.find(params[:id])
  end

  # POST /business_managers
  # POST /business_managers.json
  def create
    @business_manager = BusinessManager.new(params[:business_manager])

    respond_to do |format|
      if @business_manager.save
        flash[:notice] = 'Business Manager was successfully created.'
        redirect_to admins_path and return
      else
        format.html { render action: "new" }
        format.json { render json: @business_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /business_managers/1
  # PUT /business_managers/1.json
  def update
    @business_manager = BusinessManager.find(params[:id])

    respond_to do |format|
      if @business_manager.update_attributes(params[:business_manager])
        format.html { redirect_to @business_manager, notice: 'Business manager was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @business_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /business_managers/1
  # DELETE /business_managers/1.json
  def destroy
    @business_manager = BusinessManager.find(params[:id])
    @business_manager.destroy

    respond_to do |format|
      format.html { redirect_to business_managers_url }
      format.json { head :no_content }
    end
  end
end
