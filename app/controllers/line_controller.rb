class LineController < ApplicationController

	before_action  :set_object, only: [:show, :update_line, :remove_line, :edit_line]
	before_action  :set_car_object, only: [:update_line, :create_line]
	before_action  :set_villes, only: [:new_line, :edit_line]
	before_action  :check_to_signup, only: [:remove_line, :update_line, :create_line, :edit_line, :new_line]
	before_action  :check_property, only: [ :update_line, :remove_line, :edit_line]
	before_action  :check_societe?, only: [:remove_line, :update_line, :create_line, :edit_line, :new_line]


	def user_lines
		@user = User.find_by(id: params["id"])
		return redirect_to liste_lines_path if not @user or @user.user?
		@lines = @user.lines
		render "liste_lines"
	end

	def show
	end

	def liste_lines
		@user = current_user if current_user
		@lines = Line.desc_order
	end

	def new_line
		@action_name = "new_line"
		@villes = Ville.all
	end

	def create_line
		result = Line.create_line(params, current_user, @car)
		
		return redirect_to show_line_path(result[:line].token) if result[:status] == 0
		redirect_to :back 
	end

	def edit_line
		@action_name = "edit_line"
		render "new_line"
	end

	def update_line
		result = @line.update_line(params, current_user, @car)
		return redirect_to show_line_path(@line.token) if result[:status] == 0
		redirect_to :back
	end

	def remove_line
		@line.destroy
		redirect_to user_lines_path(current_user.id)
	end

	private

	def check_property
		redirect_liste_lines unless @line
		redirect_liste_lines unless current_user
		redirect_liste_lines unless @line.car.user_id == current_user.id
	end

	def redirect_liste_lines
		redirect_to liste_lines_path
		return
	end

	def set_object
		@line = Line.find_by(token: params["token"])
		redirect_liste_lines unless @line
	end

	def set_car_object
		@car = Car.find_by(token: params["line"]["car_token"])
		redirect_liste_lines unless @car
	end

	def set_villes
		@villes = Ville.all
	end

	def check_societe?
		redirect_liste_lines unless current_user.societe?
	end
end
