require 'faker'
namespace :db do
	desc "Fill database with sample data"
		task :populate => :environment do
			Rake::Task['db:reset'].invoke
			make_users
			make_microposts
			make_relationships
			make_clubs
			make_weather
			make_categories
		end
	end
	def make_users
		admin = User.create!(:name => "Example User",
		:email => "example@railstutorial.org",
		:password => "foobar",
		:password_confirmation => "foobar")
		admin.toggle!(:admin)
		50.times do |n|
			name = "User.#{n+1}"
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(:name => name,
						:email => email,
						:password => password,
						:password_confirmation => password)
			end
	end
	def make_microposts
		User.all(:limit => 6).each do |user|
			50.times do
				content = Faker::Lorem.sentence(5)
				user.microposts.create!(:content => content)
			end
		end
	end
	def make_relationships
		users = User.all
		user = users.first
		following = users[1..50]
		followers = users[3..40]
		following.each { |followed| user.follow!(followed) }
		followers.each { |follower| follower.follow!(user) }
	end
	def make_categories
		25.times do |n|
			name = "Category-#{n+1}"
			description = 'please add description'
			Category.create!(:name => name,
						:description => description,
						)
		end
	end
	def make_clubs
		20.times do |n|
			name = "Club-#{n+1}"
			email = "example-#{n+1}@railstutorial.org"
			logo_url = 'logo.png'
			description = 'please add description'
			Organization.create!(:name => name,
						:email => email,
						:description => description,
						:category_id => 1
						)
		end
	end
	def make_weather
		Weather.create(:time => '11-11-2012',
					:condition => "fair",
					:temp_c => 30.1,
					:temp_f => 80.2,
					:icon_url => "/img.png",
					:location => "College Park"
					)
	end
