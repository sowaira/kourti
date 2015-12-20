class UserController < ApplicationController

	before_action  :check_login, only: [:signup, :create_user, :login, :new_session]

	def signup
		@action_name = "signup"
	end

	def create_user
		result = User.signup(params) 
		if result[:status] == 0
			session[:user_id] = result[:user].id
			redirect_to profile_path
		else
			redirect_to :back
		end
	end

	def login
		@action_name = "login"
	end

	def new_session
		result = User.login(params)
		if result[:status] == 0
			session[:user_id] = result[:user].id
			redirect_to profile_path
		else
			redirect_to :back
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
		@action_name = "edit_profile"
		@user = current_user
		redirect_to profile_path unless @user
	end

	def update_user
		result = current_user.update_user(params) 
		return redirect_to profile_path if result[:status] == 0
		redirect_to :back
	end

	def check_login
		redirect_to profile_path if current_user 
	end
end


