class User < ActiveRecord::Base

	has_many :tels
	has_many :cars
	has_many :lines, through: :cars
	has_many :comments
	has_many :likes

	enum type_user: [:societe, :user]

	def self.signup(params)
		check_params = GlobalOperations.missing_params?(params["user"]["email"],
										 params["user"]["password"],
										 params["user"]["name"],
										 params["user"]["username"],
										 params["user"]["type_user"])

		return {status:1} unless check_params
		return {status:1} unless GlobalOperations.email_valid?(params["user"]["email"])
		return {status:1} unless [0, 1].include? params["user"]["type_user"].to_i

		check_user_exist = User.find_by(email: params["user"]["email"])

		return {status:2} if check_user_exist 
			
		password_elms = User.create_hashed_password(params["user"]["password"])

		user = User.create( name: params["user"]["name"],
							email: params["user"]["email"],
							username: params["user"]["username"],
							password: password_elms[:hashed_password],
							salt: password_elms[:salt],
							adresse: params["user"]["adresse"],
							type_user: params["user"]["type_user"].to_i)

		params["user"]["tels"].each do |tel|
			Tel.create(number:tel,
					   user_id: user.id)
		end if params["user"]["tels"]

		UserMailer.welcome_mail(user).deliver_later
		
		{status:0, user: user}
	end


	def self.create_hashed_password(password)
		salt = SecureRandom.base64(8)
		{hashed_password: Digest::SHA2.hexdigest(salt + password), salt: salt}
	end

	def password_correct?(hashed_password, password_to_confirm, salt)
  		hashed_password == Digest::SHA2.hexdigest(salt + password_to_confirm)
	end

	def self.login(params)
		check_params = GlobalOperations.missing_params?(params["user"]["email"],
									   params["user"]["password"])
		return {status:1} unless check_params
		return {status:1} unless GlobalOperations.email_valid?(params["user"]["email"])
		user = User.find_by(email: params["user"]["email"])

		return {status:2} unless user

		check_password = user.password_correct?(user.password, params["user"]["password"], user.salt)
		return {status:2} unless check_password	
		return  {status:0, user: user} if check_password	
	end 

	def update_user(params)
		check_params = GlobalOperations.missing_params?(params["user"]["email"],
										 params["user"]["name"],
										 params["user"]["username"],
										 params["user"]["image_link"])

		return {status:1} unless check_params
		return {status:1} unless GlobalOperations.email_valid?(params["user"]["email"])

		self.update(name: params["user"]["name"],
					username: params["user"]["username"],
					email: params["user"]["email"],
					adresse: params["user"]["adresse"]
					)

		image = Image.find_by(object_id: self.id, class_name:"User", image_type:0)

		Image.create(object_id: self.id, class_name:"User", link:params["user"]["image_link"], image_type:0) unless image
		image.update(object_id: self.id, class_name:"User", link:params["user"]["image_link"], image_type:0) if image
		
		self.tels.destroy_all
		params["user"]["tel_numbers"].each_with_index do |tel|
			Tel.create(number:tel, user_id: self.id) if GlobalOperations.number?(tel)
		end if params["user"]["tel_numbers"]
		{status:0}
	end

	def owner_of?(obj)
		obj.user_id == self.id
	end

	def liked?(class_name, obj)
		!!self.likes.find_by(class_name: class_name, object_id: obj.id)
	end

	def cover_image
		image = Image.find_by(class_name: "User", object_id: self.id, image_type:0)
		image_link = image.link if image
		image_link || "/images/default-thumb.png"
	end

end
