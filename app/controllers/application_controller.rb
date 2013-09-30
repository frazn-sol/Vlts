class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def after_sign_in_path_for(resource)
  	if params[:customer]
  		customers_path
  	else
  		admins_path
  	end
  end

end
