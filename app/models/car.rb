class Car < ActiveRecord::Base
	has_many :lines
	belongs_to :user
	has_many :comments

	def self.create_car(params, current_user)
		car = Car.create(name: params["car"]["name"],
						 user_id: current_user.id,
						 status: 0)
		car
	end

	def update_car(params,current_user)
		car = self.update(name: params["car"]["name"])
	end
end
