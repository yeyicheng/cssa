module SessionsHelper
	def current_club
		Organization.find(session[:current_club])
	end
	
	def sign_in(user)
		cookies.signed[:remember_token] = {:value => [user.id, user.salt], :expires => 1.hour.from_now}
		current_user = user
	end
	
	def alias_sign_in(user)
		cookies.signed[:remember_token] = {:value => [user.id, user.salt], :expires => 1.hour.from_now}
		current_user = user
	end
	
	def current_user=(user)
		@current_user = user
	end
	
	def current_user
		@current_user ||= user_from_remember_token
	end
	
	def signed_in?
		!current_user.nil?
	end
			
	def sign_out
		session[:user_id] = ''
		session[:identity_id] = ''
		cookies.delete(:remember_token)
		current_user = nil
	end
	
	def current_user?(user)
		current_user == user
	end
	
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		clear_return_to
	end
			
	def deny_access
		store_location
		redirect_to sign_in_path, :notice => "Please sign in to access this page."
	end
	
	def authenticate
		deny_access unless signed_in?
	end
	
	def admin_auth
		deny_access unless signed_in? && current_user.admin?
	end
	
	def correct_user?
		@user = User.find(params[:id])
		current_user? @user
	end
	
	def correct_user
		if params[:id]
			@user = User.find(params[:id])
			redirect_to @user, :alert => "Sorry, you don\'t have the permission to edit this user's profile." unless current_user?(@user)
		else
			redirect_to(root_path) unless current_user.admin?
		end
	end
	
	private
		
		def user_from_remember_token
			User.authenticate_with_salt(*remember_token)
		end
		
		def remember_token
			cookies.signed[:remember_token] || [nil, nil]
		end

		def store_location
			session[:return_to] = request.fullpath
		end
		
		def clear_return_to
			session[:return_to] = nil
		end
end
