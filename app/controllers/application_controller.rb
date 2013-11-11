class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def after_sign_in_path_for(resource)
    binding.pry
  	if resource.pass_change == false && resource.role != "admin"
  		flash[:notice] = "You must change your password"
  		password_user_path(resource) 
  	else	
    	users_path
    end
  end

end
