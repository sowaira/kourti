class Like < ActiveRecord::Base
	belongs_to :user


	def self.create_like(params, current_user, obj)
		return unless current_user 
		return unless GlobalOperations.number?(params["type_action"])
		return if params["type_action"].to_i < 0 or params["type_action"].to_i > 1
		return if current_user.liked?(params["class_name"], obj)
		like = Like.create(class_name: params["class_name"],
					 	object_id: obj.id,
				 		user_id: current_user.id,
				 		type_action: params["type_action"]
				 ) 
		
	end
end
