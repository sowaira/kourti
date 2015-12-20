class CarController < ApplicationController

	before_action  :set_object, only: [:show, :update_car, :remove_car, :edit_car]
	before_action  :check_to_signup, only: [:create_car, :update_car, :remove_car, :edit_car]
	before_action  :check_property, only: [ :update_car, :remove_car, :edit_car]
	before_action  :check_societe?, only: [ :create_car, :update_car, :remove_car, :edit_car]


	def new_car
		@action_name = "new_car"
	end

	def user_cars
		@user = User.find_by(id: params["id"])
		return redirect_to list_cars_path if not @user or @user.user?
		@cars = @user.cars 
		render "list_cars"
	end

	def list_cars
		@user = current_user if current_user
		@cars = Car.desc_order
	end

	def show
	end

	def edit_car
		@action_name = "edit_car"
		render 'new_car'
	end

	def update_car
		result = @car.update_car(params, current_user)
		redirect_to show_car_path(@car.token) if result[:status] == 0
		redirect_to :back unless result[:status] == 0
	end

	def create_car
		result = Car.create_car(params, current_user)
		redirect_to show_car_path(result[:car].token) if result[:status] == 0
		redirect_to :back unless result[:status] == 0
	end

	def remove_car
		@car.destroy
		redirect_to user_cars_path(current_user.id)
	end

	private

	def check_property
		redirect_list_cars unless @car
		redirect_list_cars unless current_user
		redirect_list_cars unless @car.user_id == current_user.id
	end

	def redirect_list_cars
		redirect_to list_cars_path
		return
	end

	def set_object
		@car = Car.find_by(token: params["token"])
		redirect_list_cars unless @car
	end

	def check_societe?
		redirect_list_cars unless current_user.societe?
	end
end
