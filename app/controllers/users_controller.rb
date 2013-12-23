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
    if current_user.role == "customer" && params[:user][:role] == "user"
      user_count = User.where(:role => "user", :delflag => "false", :parent_id => "#{current_user.id}").count
      @children = current_user.children
      @children.each do |child|
        user_count = user_count + User.where(:delflag => "false", :role => "user", :parent_id => child.id).count
      end
      restriction = UserConfig.where(:user_id => "#{current_user.id}")
    elsif current_user.role == "supervisor" && params[:user][:role] == "user"
      user_count = User.where(:role => "user", :delflag => "false", :parent_id => "#{current_user.parent.id}").count
      @children = current_user.parent.children
      @children.each do |child|
        user_count = user_count + User.where(:delflag => "false", :role => "user", :parent_id => child.id).count
      end
      restriction = UserConfig.where(:user_id => "#{current_user.parent_id}")
    end
    if restriction.blank?
      respond_to do |format|
        if @user.save
          UserMailer.welcome_email(@user).deliver
          if @user.role == "support"
            format.html { redirect_to support_users_path, notice: 'Support Staff was successfully created.' }
            format.json { render json: @user, status: :created, location: @user }
          elsif @user.role == "supervisor" 
            format.html { redirect_to supervisor_users_path, notice: 'Supervisor was successfully created.' }
            format.json { render json: @user, status: :created, location: @user }
          elsif @user.role == "user"
            format.html { redirect_to user_users_path, notice: 'User was successfully created.' }
            format.json { render json: @user, status: :created, location: @user }
          end  
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    elsif restriction.present? && user_count < restriction[0].usercapacity  
      respond_to do |format|
        if @user.save
          if @user.role == "support"
            format.html { redirect_to support_users_path, notice: 'Support Staff was successfully created.' }
            format.json { render json: @user, status: :created, location: @user }
          elsif @user.role == "supervisor" 
            format.html { redirect_to supervisor_users_path, notice: 'Supervisor was successfully created.' }
            format.json { render json: @user, status: :created, location: @user }
          elsif @user.role == "user"
            format.html { redirect_to user_users_path, notice: 'User was successfully created.' }
            format.json { render json: @user, status: :created, location: @user }
          end
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:notice] = "You are not allowed to create more users because you have already reach your limit"
      respond_to do |format|  
        if @user.role == "support"
          format.html { redirect_to support_users_path }
          format.json { render json: @user, status: :created, location: @user }
        elsif @user.role == "supervisor" 
          format.html { redirect_to supervisor_users_path}
          format.json { render json: @user, status: :created, location: @user }
        elsif @user.role == "user"
          format.html { redirect_to user_users_path}
          format.json { render json: @user, status: :created, location: @user }
        end
      end 
    end    
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        if params[:id] == current_user.id.to_s
          format.html { redirect_to users_path, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        end  
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

  if params[:user][:current_password].blank?
    flash[:notice] = "Current Password can't be blank"
    render action: "password" and return
  elsif params[:user][:password].blank? || params[:user][:password_confirmation] != params[:user][:password]
    flash[:notice] = "Please Enter the password again"
    render action: "password" and return
  end    

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
        redirect_to reset_users_path
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
      @system_config = SystemConfig.last
      @user_config = UserConfig.new  
    end
  end

  def change_create
    @system_config = SystemConfig.last
    respond_to do |format|
      if @system_config.update_attributes(params[:system_config])
        format.html { redirect_to change1_users_path, notice: 'Configurations were successfully created.' }
        format.json { render json: @system_config, status: :created, location: @system_config }
      else
        format.html { render action: "config" }
        format.json { render json: @system_config.errors, status: :unprocessable_entity }
      end
    end
  end

  def config_create
    @check = UserConfig.where(:customer_id => params[:user_config][:customer_id])
    if @check.blank?
      @user_config = UserConfig.new(params[:user_config])
      @user_config.user_id = User.where(:customer_id => params[:user_config][:customer_id])[0].id
      respond_to do |format|
        if @user_config.save
          format.html { redirect_to change1_users_path, notice: 'configurations were successfully created.' }
          format.json { render json: @user_config, status: :created, location: @user_config }
        else
          format.html { render action: "config" }
          format.json { render json: @user_config.errors, status: :unprocessable_entity }
        end
      end
    else
      @user_config = UserConfig.find_by_customer_id(params[:user_config][:customer_id])
      respond_to do |format|
        if @user_config.update_attributes(params[:user_config])
          format.html { redirect_to change1_users_path, notice: 'configurations were successfully created.' }
          format.json { render json: @user_config, status: :created, location: @user_config }
        else
          format.html { render action: "config" }
          format.json { render json: @user_config.errors, status: :unprocessable_entity }
        end
      end
    end  
  end

  def configuration
    @msg = Hash.new
    @config = UserConfig.where(:customer_id => "#{params[:id]}").last
    if @config.present?
      @msg["vehiclecapacity"] = @config.vehiclecapacity  
      @msg["floorcapacity"] = @config.floorcapacity
      @msg["usercapacity"] = @config.usercapacity
    else  
      @msg = nil
    end 
    respond_to do |format|
      format.html
      format.json { render json: @msg }
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
