class OrganizationsController < ApplicationController
  before_filter :authenticate_user!
  # GET /organizations
  # GET /organizations.json
  def index
    if current_user.role == ("customer" || "supervisor")
      @organizations = Organization.paginate(:page => params[:page], :per_page => 5)

      respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organizations }
    end
  else
    redirect_to error_users_path and return
  end
end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    if current_user.role == ("customer" || "supervisor")
      @organization = Organization.find(params[:id])

      respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organization }
    end
  else
    redirect_to error_users_path and return
  end
end

  # GET /organizations/new
  # GET /organizations/new.json
  def new
    if current_user.role == ("customer" || "supervisor")
      @organization = Organization.new

      respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organization }
    end
  else
    redirect_to error_users_path and return
  end
end

  # GET /organizations/1/edit
  def edit
    if current_user.role == ("customer" || "supervisor")
      @organization = Organization.find(params[:id])
    else
      redirect_to error_users_path and return
    end
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(params[:organization])
    @organization.user_id = current_user.id
    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render json: @organization, status: :created, location: @organization }
      else
        format.html { render action: "new" }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /organizations/1
  # PUT /organizations/1.json
  def update
    @organization = Organization.find(params[:id])

    respond_to do |format|
      if @organization.update_attributes(params[:organization])
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    if current_user.role == ("customer" || "supervisor")    
      @organization = Organization.find(params[:id])
      @organization.destroy

      respond_to do |format|
        format.html { redirect_to organizations_url }
        format.json { head :no_content }
      end
    else
      redirect_to error_users_path and return
    end    
  end
end
