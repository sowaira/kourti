class User < ActiveRecord::Base

	has_many :tels
	has_many :cars
	has_many :comments
	has_many :notes

	def self.signup(params)
		user = User.find_by(username: params["user"]["username"],
						    password: params["user"]["password"])
		if user 
			user
		else
			user = User.create(name: params["user"]["name"],
						username: params["user"]["username"],
						password: params["user"]["password"],
						adresse: params["user"]["adresse"],
						type_user: params["user"]["type_user"].to_i)
			params["user"]["tel"].each do |tel|
				Tel.create(number:tel,
						   user_id: user.id)
			end
			user
		end
	end

	def self.login(params)
		user = User.find_by(username: params["user"]["username"],
						    password: params["user"]["password"])
		if user 
			user
		else
			false
		end
	end

	def update_user(params)
		 self.update(name: params["user"]["name"],
						username: params["user"]["username"],
						password: params["user"]["password"],
						adresse: params["user"]["adresse"]
						)
			# i=0
			params["user"]["tel_numbers"].each_with_index do |tel, index|
				tele = Tel.find_by(id: params["user"]["tel_ids"][index])
				tele.update(number:tel, user_id: self.id)
				# i+=1
			end
			
	end

end
