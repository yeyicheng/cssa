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
	
	factory :organization do
		name		'Example Club'
		description	'ddjjj ddddd'
		email		'aa@dd.com'
	end
	
	factory :category do
		name		'Excample Category'
		description	'add some description'
	end
	
	sequence :email do |n|
		"person-#{n}@example.com"
	end
	
	sequence :name do |n|
		"Name-#{n}"
	end
	
	factory :micropost do
		content "sigh"
		association :user
	end
end
