class VehiclesController < ApplicationController
  before_filter :authenticate_user!
  autocomplete :vehicle, :platenumber, :full => true
  # GET /vehicles
  # GET /vehicles.json
  def index
    @vehicles = Vehicle.paginate(:page => params[:page], :per_page => 5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vehicles }
    end
  end

  # GET /vehicles/1
  # GET /vehicles/1.json
  def show
    @vehicle = Vehicle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vehicle }
    end
  end

  # GET /vehicles/new
  # GET /vehicles/new.json
  def new
    @vehicle = Vehicle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vehicle }
    end
  end

  # GET /vehicles/1/edit
  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  # POST /vehicles
  # POST /vehicles.json
  def create
    @vehicle = Vehicle.new(params[:vehicle])

    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to @vehicle, notice: 'Vehicle was successfully created.' }
        format.json { render json: @vehicle, status: :created, location: @vehicle }
      else
        format.html { render action: "new" }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
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
    @vehicle = Vehicle.find(params[:id])
    @vehicle.destroy

    respond_to do |format|
      format.html { redirect_to vehicles_url }
      format.json { head :no_content }
    end
  end

  def track
    @vehicle_history = VehicleHistory.new
    @search = VehicleHistory.search(params[:search])
    if (params[:search].blank? ||  (params[:search].values[0]=="" &&  params[:search].values[1]==""))
      @history = nil
    else
    @history = @search.paginate(:page => params[:page], :per_page => 5)
  end
  end

  def track_create
    @vehicle_history = VehicleHistory.new(params[:vehicle_history])
    @vehicle_history.vehicle_id = Vehicle.find_by_platenumber(params[:vehicle_history][:platenumber]).id.to_s
    respond_to do |format|
      if @vehicle_history.save
        binding.pry
        format.html { redirect_to track_vehicles_path , notice: 'Record was successfully created.' }
        format.json { render json: @vehicle_history, status: :created, location: @vehicle_history }
      else
        format.html { render action: "track" }
        format.json { render json: @vehicle_history.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_vehicle
    @vehicle = Vehicle.new
    @search = Vehicle.search(params[:search])
    if (params[:search].blank? ||  (params[:search].values[0]=="" &&  params[:search].values[1]==""))
      @vehicles = nil
    else
    @vehicles = @search.paginate(:page => params[:page], :per_page => 5)
  end
  end

  def create_vehicles
    @vehicle = Vehicle.new(params[:vehicle])

    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to add_vehicle_vehicles_path, notice: 'Vehicle was successfully created.' }
        format.json { render json: @vehicle, status: :created, location: @vehicle }
      else
        format.html { render action: "add_vehicles" }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end
end
