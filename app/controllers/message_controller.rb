class MessageController < ApplicationController

	def create_mesg
		UserMailer.contact_mail(params).deliver_later
		redirect_to home_path
	end

end
