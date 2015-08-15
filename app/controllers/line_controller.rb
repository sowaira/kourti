class LineController < ApplicationController

	def liste_lines
		@lines = Line.all
	end

	def new_line
		@action_name = "new_line"
		@villes = Ville.all
	end

	def create_line
		if Line.create_line(params, current_user)
			redirect_to new_line_path
		end
	end

	def remove_line
		line = Line.find_by(id: params["id"])
		if line
			line.destroy
		end
		redirect_to liste_lines_path
	end

	def edit_line
		@line = Line.find_by(id: params["id"])
		unless @line
			redirect_to liste_lines_path
		else

			@villes = Ville.all
			@action_name = "edit_line"
			render 'new_line'
		end
	end

	def update_line
		@line = Line.find_by(id: params["id"])
		@line.update_line(params, current_user)
		redirect_to liste_lines_path
	end
end
