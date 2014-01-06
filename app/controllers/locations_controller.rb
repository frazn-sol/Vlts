class LocationsController < ApplicationController
  before_filter :authenticate_user!
  # GET /locations
  # GET /locations.json
  def index
    if (current_user.role == "customer" ||  current_user.role == "supervisor")
      if current_user.role == "customer"
        @customer = current_user
      else
        @customer = current_user.parent
      end
      @locations = Location.where(:delflag => false, :user_id => @customer.id)
        @customer.children.each do |child|
          if child.delflag == false && child.role == "supervisor"
            @location1 = Location.where(:user_id => child.id, :delflag => false)
            @locations = @location1 + @locations
          end
        end
      @locations = @locations.paginate(:page => params[:page], :per_page => 5)
      
      respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  else
    redirect_to error_users_path and return
  end
end
  # GET /locations/1
  # GET /locations/1.json
  def show
    if (current_user.role == "customer" ||  current_user.role == "supervisor")
      add_breadcrumb "Location", 'locations_path'
      add_breadcrumb "View", '#'
      @location = Location.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @location }
      end
    else
      redirect_to error_users_path and return
    end        
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
    if (current_user.role == "customer" ||  current_user.role == "supervisor")
      add_breadcrumb "Location", 'locations_path'
      add_breadcrumb "Add new", '#'
      @location = Location.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @location }
      end
    else
      redirect_to error_users_path and return
    end        
  end

  # GET /locations/1/edit
  def edit
    if (current_user.role == "customer" ||  current_user.role == "supervisor")
      add_breadcrumb "Location", 'locations_path'
      add_breadcrumb "Update", '#'
      @location = Location.find(params[:id])
    else
      redirect_to error_users_path and return
    end        
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(params[:location])
    @location.user_id = current_user.id

    respond_to do |format|
      if @location.save
        format.html { redirect_to locations_path, notice: 'Location was successfully created.' }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    if (current_user.role == "customer" || current_user.role == "supervisor")
      @location = Location.find(params[:id])
      @action = request.referrer
      @location.delflag = true
      if @location.update_attributes(params[:location])
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
