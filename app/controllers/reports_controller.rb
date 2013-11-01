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

		@pie = Gchart.pie(:data => @users.values, :labels => user.values, :size => '800x300', :legend => ['Users growth'], :title => 'Users growth', :bg => "efefef")
		@line = Gchart.line(:size => '800x300', 
            :title => "Growth",
            :bg => 'efefef',
            :legend => ['Users growth'],
            :data => @users.values,
            :axis_with_labels => 'x',
            :axis_labels => [user.values, @users.values],
            :line_colors => '76A4FB')
	end
end
