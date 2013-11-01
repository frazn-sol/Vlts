class ReportsController < ApplicationController
	require 'gchart'

	def admin
		user = Hash.new
		date = Date.today-30
		@users = User.count(:conditions=>["created_at >= ?", date], :order => "EXTRACT(month FROM created_at)", :group => ["EXTRACT(month FROM created_at)"])
		date.upto(Date.today) do |x|
  		@users[x.to_s] ||= 0
		end
		@users.delete_if {|key, value| key >= "20"}
		@users.each do |key, value|
		user[key+Time.now.to_s] = t("date.month_names")[key.to_i]
		end

		@pie = Gchart.pie_3d(:bg => "aaff00", :data => @users.values, :labels => user.values, :size => '500x230', :legend => ['Users growth'], :title => 'Users growth', :bg => "efefef")
		@line = Gchart.line(:size => '500x250', 
            :title => "Growth",
            :bg => 'aaff00',
            :legend => ['Users growth'],
            :data => @users.values,
            :axis_with_labels => 'x,r',
            :axis_labels => [user.values, @users.values],
            :line_colors => '76A4FB')
	end

	def support
		user = Hash.new
		date = Date.today-30
		@users = current_user.children.count(:conditions=>["created_at >= ?", date], :order => "EXTRACT(month FROM created_at)", :group => ["EXTRACT(month FROM created_at)"])
		date.upto(Date.today) do |x|
  		@users[x.to_s] ||= 0
		end
		@users.delete_if {|key, value| key >= "20"}
		@users.each do |key, value|
		user[key+Time.now.to_s] = t("date.month_names")[key.to_i]
		end

		@pie = Gchart.pie_3d(:bg => "green", :data => @users.values, :labels => user.values, :size => '600x300', :legend => ['Users growth'], :title => 'Users growth', :bg => "efefef")
	end

	def supervisor
		user = Hash.new
		date = Date.today-30
		@users = current_user.children.count(:conditions=>["created_at >= ?", date], :order => "EXTRACT(month FROM created_at)", :group => ["EXTRACT(month FROM created_at)"])
		date.upto(Date.today) do |x|
  		@users[x.to_s] ||= 0
		end
		@users.delete_if {|key, value| key >= "20"}
		@users.each do |key, value|
		user[key+Time.now.to_s] = t("date.month_names")[key.to_i]
		end

		@pie = Gchart.pie_3d(:bg => "000000", :data => @users.values, :labels => user.values, :size => '600x300', :legend => ['Users growth'], :title => 'Users growth', :bg => "efefef")
	end

	def customer
		user = Hash.new
		date = Date.today-30
		@users = current_user.children.count(:conditions=>["created_at >= ?", date], :order => "EXTRACT(month FROM created_at)", :group => ["EXTRACT(month FROM created_at)"])
		date.upto(Date.today) do |x|
  		@users[x.to_s] ||= 0
		end
		@users.delete_if {|key, value| key >= "20"}
		@users.each do |key, value|
		user[key+Time.now.to_s] = t("date.month_names")[key.to_i]
		end

		@pie = Gchart.pie_3d(:bg => '000000', :data => @users.values, :labels => user.values, :size => '500x230', :legend => ['Users growth'], :title => 'Users growth', :bg => "efefef")
		@line = Gchart.line(:bg => 'aaee00', :size => '500x250', 
            :title => "Growth",
            :legend => ['Users growth'],
            :data => @users.values,
            :axis_with_labels => 'x,r',
            :axis_labels => [user.values, @users.values],
            :line_colors => '76A4FB')
	end
end
