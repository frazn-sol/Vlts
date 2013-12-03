class UsersController < ApplicationController
  before_filter :authenticate_user
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
    type = User.where(:id => params[:id])[0].role
    typename = ENV[type]
    add_breadcrumb "#{typename}", "#{type}_users_path"
    add_breadcrumb "#{User.where(:id => params[:id])[0].first_name}", '#'
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    type = params[:param]
    if type == nil
      add_breadcrumb "Support Staff", "support_users_path"
      add_breadcrumb "Add new", ''
    else  
      systype = type+'type'
      systypename = ENV[systype]
      add_breadcrumb "#{ENV[type]}", "#{ENV[systype]}_users_path"
      add_breadcrumb "Add new", ''    
    end
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    if current_user.id.to_s != params[:id]
      typename = ENV[User.where(:id => params[:id])[0].role]
      add_breadcrumb "#{typename}", 'support_users_path'
      add_breadcrumb "#{User.where(:id => params[:id])[0].first_name}", '#'
    end
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.parent_id = current_user.id
    
    respond_to do |format|
      if @user.save
        UserMailer.welcome_email(@user).deliver
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
    @action = request.referrer
    @user.delflag = true
    if @user.update_attributes(params[:user])
      @customer = Customer.where(:user_id => "#{@user.id}", :delflag => "false")
      if @customer.present?
        @customer.each do |c|
         c.delflag = true
         Customer.where(:id => c.id).update_all(:deflag => true)
        end
      end 
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

  end

  def support
    if current_user.role == "admin" 
      @user = User.where(:role => "support", :delflag => false)
      @users = @user.paginate(:page => params[:page], :per_page => 5)
    else 
      redirect_to error_users_path
    end  
  end

  def supervisor
    if current_user.role == "customer" 
      @user = User.where(:parent_id => "#{current_user.id}", :role => "supervisor", :delflag => false)
      @users = @user.paginate(:page => params[:page], :per_page => 5)
    else 
      redirect_to error_users_path   
    end  
  end

  def user
    if (current_user.role == "customer" || current_user.role == "supervisor")
      @user = User.where(:role => "user", :parent_id => "#{current_user.id}", :delflag => false)
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
      redirect_to users_path and return
    else
      flash[:notice] = @user.errors.full_messages.join("&")
      render action: "password"
    end  
  end

  def reset
    @user = current_user
  end

  def reset1
    @user = User.find_by_email(params[:user][:try])
    if @user
      params[:user].delete(:try) 
      params[:user][:id] = @user.id.to_s

      account_update_params = params[:user]

      # required for settings form to submit when password is left blank
      if account_update_params[:password].blank?
        account_update_params.delete("password")
        account_update_params.delete("password_confirmation")
      end

      if @user.update_attributes(account_update_params)
        UserMailer.reset_email(@user).deliver
        flash[:notice] = "Password has been successfully updated"
        # Sign in the user bypassing validation in case his password changed
        redirect_to users_path
      else
        flash[:notice] = @user.errors.full_messages.join("&")
        render "reset"
      end
    else
      flash[:notice] = "Email does not exist"
      redirect_to reset_users_path and return
    end
    # if @user.update_with_password(params[:user])
    #   flash[:notice] = "Password has been successfully updated"
    #   sign_in @user, :bypass => true
    #   redirect_to user_path and return
    # else
    #     flash[:notice] = @user.errors.full_messages.join("&")
    #     render action: "password"
    # end  
  end

  def forgot
    @user = User.find(1)
    render layout: false
  end

  def email
    @user = User.find_by_email(params[:user][:forgot])
    if @user != nil
      UserMailer.forgot_email_to_user(@user).deliver
      @u = User.where(:role => "admin")
      UserMailer.forgot_email_to_admin(@user, @u).deliver
      flash[:notice] = "You will soon recieve an email with new password"
      redirect_to forgot_users_path and return
    else
      flash[:notice] = "The email you entered does not exist"
      redirect_to forgot_users_path and return
    end
  end


  def error 
    render layout: false
  end

  def change1
    if current_user.role == "admin" || current_user.role == "support" 
      @logo = Logo.last
      @config = Change.new  
    end
  end

  def change_create
    @logo = Logo.last
    respond_to do |format|
      if @logo.update_attributes(params[:logo])
        format.html { redirect_to change1_users_path, notice: 'configurations were successfully created.' }
        format.json { render json: @logo, status: :created, location: @logo }
      else
        format.html { render action: "config" }
        format.json { render json: @logo.errors, status: :unprocessable_entity }
      end
    end
  end

  def config_create
    @config = Change.new(params[:change])
    respond_to do |format|
      if @config.save
        format.html { redirect_to change1_users_path, notice: 'configurations were successfully created.' }
        format.json { render json: @config, status: :created, location: @config }
      else
        format.html { render action: "config" }
        format.json { render json: @config.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def authenticate_user
    if action_name == "forgot" || action_name == "email"
      return false
    elsif current_user.blank?
      redirect_to "/users/sign_in"
    else  
      return true
    end
  end

  def set_breadcrumb_for cat
    set_breadcrumb_for cat.parent if cat.parent
    add_breadcrumb cat.first_name, "users_path(#{cat.id})"
  end

end
