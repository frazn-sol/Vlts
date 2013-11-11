class UsersController < ApplicationController
  before_filter :authenticate_user!
  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(:page => params[:page], :per_page => 5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.parent_id = current_user.id
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def support
    if current_user.role == "admin" 
      @user = User.where(:role => "support")
      @users = @user.paginate(:page => params[:page], :per_page => 5)
    else 
      redirect_to error_users_path
    end  
  end

  def supervisor
    if current_user.role == "customer" 
      @user = User.where(:role => "supervisor")
      @users = @user.paginate(:page => params[:page], :per_page => 5)
    else 
      redirect_to error_users_path   
    end  
  end

  def user
    if (current_user.role == "customer" || current_user.role == "supervisor")
      @user = User.where(:role => "user")
      @users = @user.paginate(:page => params[:page], :per_page => 5)
    else 
      redirect_to error_users_path   
    end  
  end

  def password
    @user = current_user
  end

  def change
    @user = current_user
    params[:current_password] = params[:user][:currently_password]
    params[:user][:current_password] = params[:current_password]
    params[:user].delete(:currently_password) 

    if @user.update_with_password(params[:user])
      flash[:notice] = "Password has been successfully updated"
      sign_in @user, :bypass => true
      redirect_to user_path and return
    else
        flash[:notice] = @user.errors.full_messages.join("&")
        render action: "password"
    end  
  end

  def error 
    render layout: false
  end

  def change1
    @logo = Logo.new
  end

  def change_create
    @logo = Logo.new(params[:logo])
    @logo.user_id = current_user.id

     respond_to do |format|
      if @logo.save
        format.html { redirect_to change1_users_path, notice: 'configurations were successfully created.' }
        format.json { render json: @logo, status: :created, location: @logo }
      else
        format.html { render action: "config" }
        format.json { render json: @logo.errors, status: :unprocessable_entity }
      end
    end
  end
end
