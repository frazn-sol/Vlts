class ReportsController < ApplicationController
	def admin

		user = Hash.new
		support = Hash.new 
		months = Hash.new
		12.times do |x|
			months[(x+1).to_s] = 0
		end
		month = Hash.new
		date = Date.today-365
		@users = User.count(:conditions=>["created_at >= ?", date], :order => "EXTRACT(month FROM created_at)", :group => ["EXTRACT(month FROM created_at)"])
	
		date.upto(Date.today) do |x|
			@users[x.to_s] ||= 0
		end
		@users.delete_if {|key, value|
		key.include? "20"}
		@users.each do |key, value|
			user[key] = t("date.month_names")[key.to_i]
		end
		months.merge!(@users)
		months = Hash[months.map {|k, v| [user[k], v] }]
		months.delete(nil)
		months.each{|key, value|
			month[key] = ((value.to_f/User.count.to_f)*100).to_i
		}
		@chart = LazyHighCharts::HighChart.new('pie') do |f|
			f.chart({:defaultSeriesType=>"pie" , :margin=> [20], :height => [300], :width => [350]} )
			series = {
				:type=> 'pie',
				:name=> 'User growth',
				:data=> month.to_a
			}
			f.series(series)
			f.options[:title][:text] = "Monthly User Growth (VLTS)"
			f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
			f.plot_options(:pie=>{
				:allowPointSelect=>true,
				:cursor=>"pointer" , 
				:dataLabels=>{
					:enabled=>true,
					:color=>"black",
					:style=>{
						:font=>"13px Trebuchet MS, Verdana, sans-serif"
					}
				}
				})
		end

		@chart1 = LazyHighCharts::HighChart.new('graph') do |f|
			f.title({ :text=>"Overall User growth (VLTS)"})
			f.options[:xAxis][:categories] = user.values
			f.series(:type=> 'column',:name=> "Users", :data=> month.values, pointWidth: 50)
		end


		@user = current_user.children
		@chart2 = LazyHighCharts::HighChart.new('graph') do |f|
			f.title({ :text=>"Support Staff Performane"})
			f.options[:xAxis][:categories] = ["Users"]

			@user.each do |user|
				support[user.first_name] = Customer.where(:user_id => "#{user.id}").count						
			end
			support.each {|key, value|
				f.series(:type=> 'column',:name=> key, :data=> [value], pointWidth: 50)
			}

		end

		@chart4 = LazyHighCharts::HighChart.new('pie') do |f|
			support.each{|key, value| 
				support[key] = ((value.to_f/User.where(:role => "customer").count.to_f)*100).to_i
			}

			f.chart({:defaultSeriesType=>"pie" , :margin=> [20], :height => [300], :width => [350]} )
			series = {
				:type=> 'pie',
				:name=> 'User growth',
				:data=> support.to_a
			}
			f.series(series)
			f.options[:title][:text] = "Support Staff Contribution"
			f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
			f.plot_options(:pie=>{
				:allowPointSelect=>true, 
				:cursor=>"pointer" , 
				:dataLabels=>{
					:enabled=>true,
					:color=>"black",
					:style=>{
						:font=>"13px Trebuchet MS, Verdana, sans-serif"
					}
				}
				})
		end

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
			user[key] = t("date.month_names")[key.to_i]
		end
		@users = Hash[@users.map {|k, v| [user[k], v] }]
		@chart = LazyHighCharts::HighChart.new('pie') do |f|
			f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
			series = {
				:type=> 'pie',
				:name=> 'User growth',
				:data=> @users.to_a
			}
			f.series(series)
			f.options[:title][:text] = "User Growth"
			f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
			f.plot_options(:pie=>{
				:allowPointSelect=>true, 
				:cursor=>"pointer" , 
				:dataLabels=>{
					:enabled=>true,
					:color=>"black",
					:style=>{
						:font=>"13px Trebuchet MS, Verdana, sans-serif"
					}
				}
				})
		end
	end

	def supervisor
		user = Hash.new
		date = Date.today - 365
		@users = current_user.children.count(:conditions=>["created_at >= ?", date], :order => "EXTRACT(month FROM created_at)", :group => ["EXTRACT(month FROM created_at)"])
		date.upto(Date.today) do |x|
			@users[x.to_s] ||= 0
		end
		@users.delete_if {|key, value| key >= "20"}
		@users.each do |key, value|
			user[key] = t("date.month_names")[key.to_i]
		end
		@users = Hash[@users.map {|k, v| [user[k], v] }]
		@chart = LazyHighCharts::HighChart.new('pie') do |f|
			f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
			series = {
				:type=> 'pie',
				:name=> 'User growth',
				:data=> @users.to_a
			}
			f.series(series)
			f.options[:title][:text] = "User Growth"
			f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
			f.plot_options(:pie=>{
				:allowPointSelect=>true, 
				:cursor=>"pointer" , 
				:dataLabels=>{
					:enabled=>true,
					:color=>"black",
					:style=>{
						:font=>"13px Trebuchet MS, Verdana, sans-serif"
					}
				}
				})
		end
	end

	def customer
		user = Hash.new
		support = Hash.new 
		months = Hash.new
		12.times do |x|
			months[(x+1).to_s] = 0
		end
		month = Hash.new
		date = Date.today-365
		@users = current_user.children.count(:conditions=>["created_at >= ?", date], :order => "EXTRACT(month FROM created_at)", :group => ["EXTRACT(month FROM created_at)"])
	
		date.upto(Date.today) do |x|
			@users[x.to_s] ||= 0
		end
		@users.delete_if {|key, value|
		key.include? "20"}
		@users.each do |key, value|
			user[key] = t("date.month_names")[key.to_i]
		end
		months.merge!(@users)
		months = Hash[months.map {|k, v| [user[k], v] }]
		months.delete(nil)
		months.each{|key, value|
			month[key] = ((value.to_f/User.count.to_f)*100).to_i
		}
		@chart = LazyHighCharts::HighChart.new('pie') do |f|
			f.chart({:defaultSeriesType=>"pie" , :margin=> [20], :height => [300], :width => [350]} )
			series = {
				:type=> 'pie',
				:name=> 'User growth',
				:data=> month.to_a
			}
			f.series(series)
			f.options[:title][:text] = "Monthly User Growth"
			f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
			f.plot_options(:pie=>{
				:allowPointSelect=>true,
				:cursor=>"pointer" , 
				:dataLabels=>{
					:enabled=>true,
					:color=>"black",
					:style=>{
						:font=>"13px Trebuchet MS, Verdana, sans-serif"
					}
				}
				})
		end

		@chart1 = LazyHighCharts::HighChart.new('graph') do |f|
			f.title({ :text=>"User Growth"})
			f.options[:xAxis][:categories] = user.values
			f.series(:type=> 'column',:name=> "Users", :data=> month.values, pointWidth: 50)
		end


		@user = current_user.children
		@chart2 = LazyHighCharts::HighChart.new('graph') do |f|
			f.title({ :text=>"Supervisor Performane"})
			f.options[:xAxis][:categories] = ["Users"]

			@user.each do |user|
				support[user.first_name] = Customer.where(:user_id => "#{user.id}").count						
			end
			support.each {|key, value|
				f.series(:type=> 'column',:name=> key, :data=> [value], pointWidth: 50)
			}

		end

		@chart4 = LazyHighCharts::HighChart.new('pie') do |f|
			support.each{|key, value| 
				support[key] = ((value.to_f/User.where(:parent_id => "#{current_user.id}").count.to_f)*100).to_i
			}

			f.chart({:defaultSeriesType=>"pie" , :margin=> [20], :height => [300], :width => [350]} )
			series = {
				:type=> 'pie',
				:name=> 'User growth',
				:data=> support.to_a
			}
			f.series(series)
			f.options[:title][:text] = "Supervisor Contribution"
			f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
			f.plot_options(:pie=>{
				:allowPointSelect=>true, 
				:cursor=>"pointer" , 
				:dataLabels=>{
					:enabled=>true,
					:color=>"black",
					:style=>{
						:font=>"13px Trebuchet MS, Verdana, sans-serif"
					}
				}
				})
		end
	end

end
