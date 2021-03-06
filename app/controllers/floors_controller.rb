class FloorsController < ApplicationController
  before_filter :authenticate_user!
  # GET /floors
  # GET /floors.json
  def index
    if (current_user.role == "customer" || current_user.role == "supervisor")
      if params[:location_id].present?
        add_breadcrumb 'Location', 'locations_path'
        add_breadcrumb "#{Location.where(:id => params[:location_id])[0].nickname}", '#'  
        add_breadcrumb "Floors", 'floors_path(:location_id => "#{params[:location_id]}")'

        @floors = Floor.where(:delflag => "false", :location_id => "#{params[:location_id]}").paginate(:page => params[:page], :per_page => 5)

        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @floors }
        end
      else
        @floors = Floor.where(:delflag => false, :user_id => "#{current_user.id}")
        @floor = Floor.where(:delflag => false, :user_id => "#{current_user.parent_id}")   
        @floors = @floors + @floor
        if current_user.role == "customer"
          current_user.children.each do |child|
            if child.delflag == false && child.role == "supervisor"
              @floor1 = Floor.where(:user_id => child.id, :delflag => false)
              @floors = @floor1 + @floors
            end
          end
        else
          current_user.children.each do |child|
            if child.delflag == false
              @floor1 = Floor.where(:user_id => child.id, :delflag => false)
              @floors = @floor1 + @floors
            end
          end
          current_user.parent.children.each do |child|
            if child.delflag == false && child.id != current_user.id
              @floor1 = Floor.where(:user_id => child.id, :delflag => false)
              @floors = @floor1 + @floors
            end
          end
        end  
        @floors = @floors.paginate(:page => params[:page], :per_page => 5)
      
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @floors }
        end
      end  
  else
    redirect_to error_users_path and return
  end
end

  # GET /floors/1
  # GET /floors/1.json
  def show
    if (current_user.role == "customer" || current_user.role == "supervisor")
      if params[:location_id].present?
        add_breadcrumb 'Location', 'locations_path'
        add_breadcrumb "#{Location.where(:id => params[:location_id])[0].nickname}", '#'  
        add_breadcrumb "Floors", 'floors_path(:location_id => "#{params[:location_id]}")'
        add_breadcrumb "View", '#' 
      end     
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
      if params[:location_id].present?
        add_breadcrumb 'Location', 'locations_path'
        add_breadcrumb "#{Location.where(:id => params[:location_id])[0].nickname}", '#'  
        add_breadcrumb "Floors", 'floors_path(:location_id => "#{params[:location_id]}")'
        add_breadcrumb "Add new", '#'
      end      
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
      if params[:location_id].present?
        add_breadcrumb 'Location', 'locations_path'
        add_breadcrumb "#{Location.where(:id => params[:location_id])[0].nickname}", '#'  
        add_breadcrumb "Floors", 'floors_path(:location_id => "#{params[:location_id]}")'
        add_breadcrumb "Update", '#'
      end      
      @floor = Floor.find(params[:id])
    else
      redirect_to error_users_path and return
    end
  end
  
    # POST /floors  
  # POST /floors.json
  def create
    if params[:floor][:loc_id].empty?
      params[:floor].delete :loc_id  
    else
      params[:floor][:location_id] = params[:floor][:loc_id]
      params[:floor].delete :loc_id
    end
    @floor = Floor.new(params[:floor])
    @floor.user_id = current_user.id
    if current_user.role == "customer"
      floor_count = Floor.where(:delflag => "false", :user_id => "#{current_user.id}").count
      @children = current_user.children
      @children.each do |child|
        floor_count = floor_count + Floor.where(:delflag => "false", :user_id => child.id).count
      end
      restriction = UserConfig.where(:user_id => "#{current_user.id}")
    else
     floor_count = Floor.where(:delflag => "false", :user_id => "#{current_user.parent.id}").count
      @children = current_user.parent.children
      @children.each do |child|
        floor_count = floor_count + Floor.where(:delflag => "false", :user_id => child.id).count
      end
      restriction = UserConfig.where(:user_id => "#{current_user.parent.id}")
    end  
    if restriction.blank?
      respond_to do |format|
        if @floor.save
          params[:floor][:location_id] = @floor.location_id
          format.html { redirect_to floors_path(:location_id => params[:floor][:location_id]), notice: 'Floor was successfully created.' }
          format.json { render json: @floor, status: :created, location: @floor }
        else
          format.html { render action: "new" }
          format.json { render json: @floor.errors, status: :unprocessable_entity }
        end
      end
    elsif restriction.present? && floor_count < restriction[0].floorcapacity
      respond_to do |format|
        if @floor.save
          params[:floor][:location_id] = @floor.location_id
          format.html { redirect_to floors_path(:location_id => params[:floor][:location_id]), notice: 'Floor was successfully created.' }
          format.json { render json: @floor, status: :created, location: @floor }
        else
          format.html { render action: "new" }
          format.json { render json: @floor.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:notice] = "You are not allowed to create more floors because you have already reach your limit"
      render action: "new" and return
    end 
  end

  # PUT /floors/1
  # PUT /floors/1.json
  def update
    @floor = Floor.find(params[:id])
    params[:floor][:location_id] = params[:floor][:loc_id]
    params[:floor].delete :loc_id
    respond_to do |format|
      if @floor.update_attributes(params[:floor])
        format.html { redirect_to floors_path, notice: 'Floor was successfully updated.' }
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
      
      @action = request.referrer
      @floor.delflag = true
      if @floor.update_attributes(params[:floor])
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
