class ApplicationController < ActionController::Base
	protect_from_forgery

	private
	#Defining the after signing path
	def after_sign_in_path_for(resource)
		if resource.pass_change == false && resource.role != "admin"
			flash[:notice] = "You must change your password"
			password_user_path(resource) 
		else	
			users_path
		end
	end

	#Both methods for displaying the breadcrumbs
	def add_breadcrumb name, url = ''
		@breadcrumbs ||= []
		url = eval(url) if url =~ /_path|_url|@/
		@breadcrumbs << [name, url]
	end

	def self.add_breadcrumb name, url, options = {}
		before_filter options do |controller|
			controller.send(:add_breadcrumb, name, url)
		end
	end

end