FactoryGirl.define do
	factory :user do
		name	"Yicheng Ye"
		email	"sz_yyc@hotmail.com"
		password	"foobar"
		password_confirmation	"foobar"
	end
	
	factory :weather do
		condition	"fair"
		temp_c		30.1
		temp_f		80.2
		icon_url	"/img.png"
		location	"College Park"
	end
end

FactoryGirl.define do
	sequence :email do |n|
		"person-#{n}@example.com"
	end
end

FactoryGirl.define do 
	factory :micropost do
		content "someone named Xiaoyu"
		association :user
	end
end
