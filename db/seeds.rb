# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

logo = SystemConfig.new
logo.copytext = "This is copytext"
logo.systemname = "VLTS"
logo.companyname = "Company name" 
logo.logo =  File.new("#{Rails.root}/app/assets/images/logo1.png")
logo.save!