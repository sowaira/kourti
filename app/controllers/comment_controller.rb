class CommentController < ApplicationController

	before_action :object_exist?, only: [ :liste_comments, :create_comment ]

	def liste_comments
		@comments = {}
		@comments = Comment.where(class_name: @object.class.name, class_id: @object.id )
		render json: @comments
	end

	def create_comment
		comment = Comment.create_comment(params, current_user, @object)
		render status: 200, json: comment
	end

	def object_exist?
		return return_empty_result unless COMMENT_CLASSES.include? params["class_name"]
		@object = params["class_name"].constantize.find_by(token: params["token"])
		return return_empty_result unless @object
	end

	def return_empty_result
		render status: 200, json: {error: "Error"}
		return
	end
		
end
