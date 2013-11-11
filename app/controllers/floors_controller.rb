class FloorsController < ApplicationController
  before_filter :authenticate_user!
  # GET /floors
  # GET /floors.json
  def index
    if (current_user.role == "customer" || current_user.role == "supervisor")
      @floors = Floor.paginate(:page => params[:page], :per_page => 5)

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @floors }
      end
    else
      redirect_to error_users_path and return
    end        
  end

  # GET /floors/1
  # GET /floors/1.json
  def show
    if (current_user.role == "customer" || current_user.role == "supervisor")
      @floor = Floor.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @floor }
      end
    else
      redirect_to error_users_path and return
    end  
  end

  # GET /floors/new
  # GET /floors/new.json
  def new
    if (current_user.role == "customer" || current_user.role == "supervisor")
      @floor = Floor.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @floor }
      end
    else
      redirect_to error_users_path and return
    end
  end

  # GET /floors/1/edit
  def edit
    if (current_user.role == "customer" || current_user.role == "supervisor")
      @floor = Floor.find(params[:id])
    else
      redirect_to error_users_path and return
    end
  end
  
    # POST /floors  
  # POST /floors.json
  def create
    @floor = Floor.new(params[:floor])

    respond_to do |format|
      if @floor.save
        format.html { redirect_to @floor, notice: 'Floor was successfully created.' }
        format.json { render json: @floor, status: :created, location: @floor }
      else
        format.html { render action: "new" }
        format.json { render json: @floor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /floors/1
  # PUT /floors/1.json
  def update
    @floor = Floor.find(params[:id])

    respond_to do |format|
      if @floor.update_attributes(params[:floor])
        format.html { redirect_to @floor, notice: 'Floor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @floor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /floors/1
  # DELETE /floors/1.json
  def destroy
    if (current_user.role == "customer" || current_user.role == "supervisor")    
      @floor = Floor.find(params[:id])
      @floor.destroy
  
      respond_to do |format|  
        format.html { redirect_to floors_url }
        format.json { head :no_content }
      end
    else
      redirect_to error_users_path and return
    end
  end
end
