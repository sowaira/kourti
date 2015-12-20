class MessageController < ApplicationController

	def create_mesg
		@message = Message.create_msg(params)
		redirect_to home_path
	end

end
