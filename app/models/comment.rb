class Comment < ActiveRecord::Base
	belongs_to :user

	def self.create_comment(params, current_user, obj)
		return unless current_user 
		return unless params["text"].present?
		comment = Comment.create(class_name: params["class_name"],
					 	class_id: obj.id,
				 		user_id: current_user.id,
				 		text: params["text"]
				 ) 
		
	end
end
