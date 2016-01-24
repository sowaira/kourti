class UserMailer < ActionMailer::Base
	default from: "from@example.com"
	layout 'mailer'

	def contact_mail(params)

		check_params = GlobalOperations.missing_params?(params["message"]["email"],
												 		params["message"]["message"],
												 		params["message"]["name"])


		return {status:1} unless check_params
		return {status:1} unless GlobalOperations.email_valid?(params["message"]["email"])


		@name = params["message"]["name"]
		@email = params["message"]["email"]
		@message = params["message"]["message"]
	    mail(to: @email, subject: 'Message de la part :'+ @name)
	end

	def welcome_mail(user)

		@name = user.name
		@email = user.email
		@message = "kolopoeroiiiiiiiiiiiii"
	    mail(to: @email, subject: 'Bienvenue :'+ @name)
	end
end
