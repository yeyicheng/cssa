FactoryGirl.define do
	factory :user do
		name	"Yicheng Ye"
		email	"sz_yyc@hotmail.com"
		password	"foobar"
		password_confirmation	"foobar"
	end
	
	factory :weather do
		time		'11'
		condition	"fair"
		temp_c		30.1
		temp_f		80.2
		icon_url	"/img.png"
		location	"College Park"
	end
	
	factory :organizations do
		name		'AAA'
		description	'ddddddd'
		email		'aa@dd.com'
		logo_url	'dff.png'
	end
end

FactoryGirl.define do
	sequence :email do |n|
		"person-#{n}@example.com"
	end
end

FactoryGirl.define do 
	factory :micropost do
		content "sigh"
		association :user
	end
end
