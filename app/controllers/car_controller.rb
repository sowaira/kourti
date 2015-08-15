class CarController < ApplicationController

	def new_car
		@action_name = "new_car"
	end

	def list_cars
		@cars = current_user.cars
	end

	def edit_car
		@car = Car.find_by(id: params["id"])
		unless @car
			redirect_to list_cars_path
		else
			@action_name = "edit_car"
			render 'new_car'
		end
	end

	def update_car
		@car = Car.find_by(id: params["id"])
		@car.update_car(params, current_user)
		redirect_to list_cars_path
	end

	def create_car
		if Car.create_car(params, current_user)
			redirect_to new_car_path
		end
	end

	def remove_car
		car = Car.find_by(id: params["id"])
		if car
			car.destroy
		end
		redirect_to list_cars_path
	end

	

end
