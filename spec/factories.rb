FactoryGirl.define do
	factory :user do
		name	"Yicheng Ye"
		email	"sz_yyc@hotmail.com"
		password	"foobar"
		password_confirmation	"foobar"
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
