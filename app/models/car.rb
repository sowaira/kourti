class Car < ActiveRecord::Base
	has_many :lines, :dependent => :delete_all
	belongs_to :user

	scope :desc_order, -> { order("created_at desc") } 

	before_create :gererate_secure_random

	def self.create_car(params, current_user)
		check_params = GlobalOperations.missing_params?(params["car"]["name"])

		return {status:1} unless check_params

		car = Car.create(name: params["car"]["name"],
						 user_id: current_user.id,
						 status: 0)
		{status:0, car: car}
	end

	def update_car(params,current_user)
		check_params = GlobalOperations.missing_params?(params["car"]["name"])
		return {status:1} unless check_params

		car = self.update(name: params["car"]["name"])
		{status:0, car: car}
	end

	def gererate_secure_random
		secure_random = SecureRandom.hex(10)
		car = self.class.find_by(token: secure_random)
		while car
			secure_random = SecureRandom.hex(10)
			car = self.class.find_by(token: secure_random)
		end
		self.token = secure_random
	end
	
	def owner_of?(obj)
		obj.car_id == self.id
	end

	def likes
		Like.where(type_action: 0, class_name: "Car", object_id: self.id)
	end

	def dislikes
		Like.where(type_action: 1, class_name: "Car", object_id: self.id)
	end
end
