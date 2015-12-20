class Message < ActiveRecord::Base

	def self.create_msg(params)

		message = Message.create(name: params["message"]["name"],
						 email: params["message"]["email"],
						 message: params["message"]["message"])
		message
	end
end
