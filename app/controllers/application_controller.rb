# encoding: utf-8
class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	helper_method :current_user

	def current_user
		if session[:user_id] 
			return User.find_by(id: session[:user_id])
		end
	end

	def check_to_signup
		return redirect_to signup_path unless current_user
	end
end
