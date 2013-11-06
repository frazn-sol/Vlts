namespace :db do
  namespace :development do
    desc "Create user records in the development database."

    task :fake_user_data => :environment do
      require 'faker'

      @role = ["support", "supervisor", "customer", "user"]

      def randomDate(params={})
        years_back = params[:year_range] || 5
        latest_year  = params [:year_latest] || 0
        year = (rand * (years_back)).ceil + (Time.now.year - latest_year - years_back)
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

      100.times do

        u = User.new(
          :first_name => Faker::Name.first_name,
          :middle_name => Faker::Name.middle_name,
          :phone => "000000",
          :cell => "00000",
          :last_name => Faker::Name.last_name,
          :created_at => randomDate(:year_range => 4, :year_latest => 0),
          :password =>"imgreat1"
          :role => @role.rand.to_s,
          :email => Faker::Internet.email
        )
        u.save!

      end
    end
  end
end