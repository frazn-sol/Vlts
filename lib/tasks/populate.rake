namespace :db do
  namespace :development do
    desc "Create user records in the development database."

    task :fake_user_data => :environment do
      require 'faker'

      @role = ["support", "customer"]

      def randomDate(params={})
        years_back = params[:year_range] || 5
        latest_year  = params [:year_latest] || 0
        year = 2013
        month = (rand * 12).ceil
        day = (rand * 31).ceil
        series = [date = Time.local(year, month, day)]
        if params[:series]
          params[:series].each do |some_time_after|
            series << series.last + (rand * some_time_after).ceil
          end
          return series
        end
        date
      end

      5.times do

        u = User.new(
          :first_name => Faker::Name.first_name,
          :phone => "000000",
          :cell => "00000",
          :last_name => Faker::Name.last_name,
          :created_at => randomDate(:year_range => 4, :year_latest => 0),
          :password =>"imgreat1",
          :role => @role.shuffle.first,
          :email => Faker::Internet.email,
          :parent_id => 1
        )

        c = Customer.new(
          :company_name => Faker::Name.first_name,
          :address1 => "xxx",
          :address2 => "xxx",
          :state => "xxx",
          :zipcode => "xxx",
          :phone1 => "xxx",
          :phone2 => "xxx",
          :web => "xxx.com",
          :created_at => randomDate(:year_range => 4, :year_latest => 0),
          :user_id => [*2..8].sample 
          )
        u.save!
        c.save!

      end
    end
  end
end