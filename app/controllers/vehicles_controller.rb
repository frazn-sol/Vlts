class VehiclesController < ApplicationController
  before_filter :authenticate_user!
  autocomplete :vehicle, :platenumber, :full => true
  # GET /vehicles
  # GET /vehicles.json
  def index
    if (current_user.role == "customer" || current_user.role == "supervisor")
      @vehicles = Vehicle.where(:delflag => false, :user_id => "#{current_user.id}").paginate(:page => params[:page], :per_page => 5) 
      respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vehicles }
    end
  else
    redirect_to error_users_path and return
  end
end

  # GET /vehicles/1
  # GET /vehicles/1.json
  def show
    if (current_user.role == "customer" || current_user.role == "supervisor" || current_user.role == "user")    
      @vehicle = Vehicle.find(params[:id])

      respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vehicle }
    end
  else
    redirect_to error_users_path and return
  end
end

  # GET /vehicles/new
  # GET /vehicles/new.json
  def new
    if (current_user.role == "customer" || current_user.role == "supervisor")    
      @vehicle = Vehicle.new

      respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vehicle }
    end
  else
    redirect_to error_users_path and return
  end
end

  # GET /vehicles/1/edit
  def edit
    if (current_user.role == "customer" || current_user.role == "supervisor" || current_user.role == "user")    
      @vehicle = Vehicle.find(params[:id])
    else
      redirect_to error_users_path and return
    end
  end

  # POST /vehicles
  # POST /vehicles.json
  def create
    @vehicle = Vehicle.new(params[:vehicle])
    @vehicle.user_id = current_user.id
    if current_user.role == "customer"
      vehicle_count = Vehicle.where(:delflag => "false", :user_id => "#{current_user.id}").count
      @children = current_user.children
      @children.each do |child|
        vehicle_count = vehicle_count + Vehicle.where(:delflag => "false", :user_id => child.id).count
      end
      restriction = UserConfig.where(:user_id => "#{current_user.id}" )
    else
      vehicle_count = Vehicle.where(:delflag => "false", :user_id => "#{current_user.parent.id}").count
      @children = current_user.parent.children
      @children.each do |child|
        vehicle_count = vehicle_count + Vehicle.where(:delflag => "false", :user_id => child.id).count
      end
      restriction = UserConfig.where(:user_id => "#{current_user.parent_id}")
    end
    if restriction.blank?
      respond_to do |format|
        if @vehicle.save
          format.html { redirect_to @vehicle, notice: 'Vehicle was successfully created.' }
          format.json { render json: @vehicle, status: :created, location: @vehicle }
        else
          format.html { render action: "new" }
          format.json { render json: @vehicle.errors, status: :unprocessable_entity }
        end
      end
    elsif restriction.present? && vehicle_count < restriction[0].vehiclecapacity
      respond_to do |format|
        if @vehicle.save
          format.html { redirect_to @vehicle, notice: 'Vehicle was successfully created.' }
          format.json { render json: @vehicle, status: :created, location: @vehicle }
        else
          format.html { render action: "new" }
          format.json { render json: @vehicle.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:notice] = "You are not allowed to create more vehicles because you have already reach your limit"
      render action: "new" and return
    end            
  end

  # PUT /vehicles/1
  # PUT /vehicles/1.json
  def update
    @vehicle = Vehicle.find(params[:id])

    respond_to do |format|
      if @vehicle.update_attributes(params[:vehicle])
        format.html { redirect_to @vehicle, notice: 'Vehicle was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicles/1
  # DELETE /vehicles/1.json
  def destroy
    if (current_user.role == "customer" || current_user.role == "supervisor" || current_user.role == "user")    
      @vehicle = Vehicle.find(params[:id])
      @action = request.referrer
      @vehicle.delflag = true
      if @vehicle.update_attributes(params[:vehicle])
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

  def track
    if current_user.role == "user"
      @vehicle_history = VehicleHistory.new
      @search = VehicleHistory.search(params[:search])
      if (params[:search].blank?)
        @history = nil
      elsif (params[:search][:platenumber_equals].blank? && params[:search][:slot_like].blank?)
        @history = nil
      else  
        @history = @search.where(:delflag => "false").paginate(:page => params[:page], :per_page => 5)
        @vehicle = Vehicle.where(:platenumber => "#{params[:search][:platenumber_equals]}") if params[:search].present?
      end
    else
      redirect_to error_users_path and return
    end
  end

  def track_create
    if current_user.role == "user"    
      @vehicle_history = VehicleHistory.new(params[:vehicle_history])
      @vehicle = Vehicle.find_by_platenumber(params[:vehicle_history][:platenumber])
      if @vehicle != nil
        @vehicle_history.vehicle_id = Vehicle.find_by_platenumber(params[:vehicle_history][:platenumber]).id.to_s
        respond_to do |format|
          if @vehicle_history.save
            format.html { redirect_to track_vehicles_path , notice: 'Record was successfully created.' }
            format.json { render json: @vehicle_history, status: :created, location: @vehicle_history }
          else
            format.html { render action: "track" }
            format.json { render json: @vehicle_history.errors, status: :unprocessable_entity }
          end
        end
      else
        flash[:notice] = "Vehicle does not exist"
        redirect_to track_vehicles_path and return 
      end 
    else
      redirect_to error_users_path and return
    end
  end

  def add_vehicle
    if current_user.role == "user"    
      @vehicle = Vehicle.new
      @search = Vehicle.search(params[:search])
      if (params[:search].blank? )
        @vehicles = Vehicle.where(:delflag => false, :user_id => "#{current_user.parent_id}" ).paginate(:page => params[:page], :per_page => 5)
      else
        @vehicles = @search.where(:delflag => false, :user_id => "#{current_user.parent_id}" ).paginate(:page => params[:page], :per_page => 5)
      end
    else
      redirect_to error_users_path and return
    end
  end

  def create_vehicles
    if current_user.role == "user" 
      @vehicle = Vehicle.new(params[:vehicle])
      @vehicle.user_id = current_user.id
      if current_user.parent.parent.present?   
        vehicle_count = Vehicle.where(:delflag => "false", :user_id => "#{current_user.parent.parent.id}").count
        @children = current_user.parent.parent.children
        @children.each do |child|
          vehicle_count = vehicle_count + Vehicle.where(:delflag => "false", :user_id => child.id).count
        end
        vehicle_count = vehicle_count + Vehicle.where(:delflag => "false", :user_id => current_user.id).count
      else
        vehicle_count = Vehicle.where(:delflag => "false", :user_id => "#{current_user.parent.id}").count
        @children = current_user.parent.children
        @children.each do |child|
          vehicle_count = vehicle_count + Vehicle.where(:delflag => "false", :user_id => child.id).count
        end
      end  
      restriction = UserConfig.where(:user_id => "#{current_user.parent_id}")
      if restriction.blank?
        respond_to do |format|
          if @vehicle.save
            format.html { redirect_to add_vehicle_vehicles_path, notice: 'Vehicle was successfully created.' }
            format.json { render json: @vehicle, status: :created, location: @vehicle }
          else
            format.html { render action: "add_vehicle" }
            format.json { render json: @vehicle.errors, status: :unprocessable_entity }
          end
        end
      elsif restriction.present? && vehicle_count < restriction[0].vehiclecapacity
        respond_to do |format|
          if @vehicle.save
            format.html { redirect_to add_vehicle_vehicles_path, notice: 'Vehicle was successfully created.' }
            format.json { render json: @vehicle, status: :created, location: @vehicle }
          else
            format.html { render action: "add_vehicle" }
            format.json { render json: @vehicle.errors, status: :unprocessable_entity }
          end
        end
      else
        flash[:notice] = "You are not allowed to create more vehicles because you have already reach your limit"
        @action = request.referrer
        redirect_to @action and return
      end        
    else
      redirect_to error_users_path and return
    end
  end

  def autocomplete
    if params[:term]
      @vehicles = Vehicle.where(:user_id => "#{current_user.id}" || "#{current_user.parent_id}" || "#{current_user.parent.parent_id}", :delflag => "false")
      @vehicle = @vehicles.find(:all,:conditions => ['platenumber LIKE ?', "%#{params[:term]}%"])
    else
      @vehicle = Vehicle.all
    end

    render json: @vehicle.as_json
  end

  def track_view
    if (current_user.role == "user")    
      @vehicle = VehicleHistory.find(params[:id])

      respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vehicle }
    end
  else
    redirect_to error_users_path and return
  end
end

def track_delete
  if (current_user.role == "user")  
    @vehicle = VehicleHistory.find(params[:id])
    @action = request.referrer
    @vehicle.delflag = true
    if @vehicle.update_attributes(params[:vehicle])
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
