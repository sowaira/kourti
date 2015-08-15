class UserController < ApplicationController

	def signup
		@action_name = "signup"
	end

	def create_user
		user = User.signup(params) 
		if user
			session[:user_id] = user.id
			redirect_to profile_path
		else
			redirect_to :back
		end
	end

	def login
		@action_name = "login"
	end

	def new_session
		user = User.login(params)
		if user
			session[:user_id] = user.id
			redirect_to profile_path
		else
			redirect_to signup_path
		end
	end

	def profile
		@user = current_user
	end

	def logout
		session[:user_id] = nil
		redirect_to login_path
	end


	def edit_user
		@user = current_user
		unless @user
			redirect_to profile_path
		end
	end

	def update_user
		@user = current_user
		@user.update_user(params)
		redirect_to profile_path
	end
end


