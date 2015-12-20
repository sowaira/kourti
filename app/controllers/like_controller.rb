class LikeController < ApplicationController

	before_action :object_exist?, only: [ :create_like ]


	def create_like
		like = Like.create_like(params, current_user, @object)
		render status: 200, json: {likes: @object.likes.size, dislikes: @object.dislikes.size}
	end

	def object_exist?
		return return_empty_result unless LIKE_CLASSES.include? params["class_name"]
		@object = params["class_name"].constantize.find_by(token: params["token"])
		return return_empty_result unless @object
	end

	def return_empty_result
		render status: 200, json: {error: "Error"}
		return
	end
		
end
