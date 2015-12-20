class Line < ActiveRecord::Base
	belongs_to :car
	has_many  :escales, :dependent => :delete_all

	before_create :gererate_secure_random

	scope :desc_order, -> { order("created_at desc") } 

	def self.create_line(params, current_user, car)
		
		return {status: 1} unless current_user.owner_of?(car)
		return {status: 1} unless GlobalOperations.time_format?(params["line"]["heure_depart"], params["line"]["heure_arrive"])
		return {status: 1} unless GlobalOperations.number?(params["line"]["prix"])
		return {status: 1} unless Ville.find_by(id: params["escale"]["depart_ville_id"])
		return {status: 1} unless Ville.find_by(id: params["escale"]["arrive_ville_id"])

		line = Line.create(heure_depart: params["line"]["heure_depart"],
						   heure_arrive: params["line"]["heure_arrive"],
						   prix:params["line"]["prix"],
						   car_id: car.id,
						   status: 0)

		Escale.create(line_id: line.id,
					  ville_id: params["escale"]["depart_ville_id"],
					  order_escale: 0)

		i_status = 1
		params["escale"]["escale_ville_id"].each do |escale_ville_id|
			next unless Ville.find_by(id: escale_ville_id)
			Escale.create(line_id: line.id,
					  	  ville_id: escale_ville_id,
					  	  order_escale: i_status)
			i_status += 1
		end if params["escale"]["escale_ville_id"]

		Escale.create(line_id: line.id,
					  ville_id: params["escale"]["arrive_ville_id"],
					  order_escale: i_status)
		
		{status: 0, line: line}
	end

	def ville_depart
		self.escales.order("order_escale asc").first.ville
	end

	def ville_arrive
		self.escales.order("order_escale asc").last.ville
	end

	def ville_escales
		escales_ = self.escales.order("order_escale asc")
		escales_ = escales_ - [escales_.first]
		escales_ = escales_ - [escales_.last]

		escales_
	end

	def likes
		Like.where(type_action: 0, class_name: "Line", object_id: self.id)
	end

	def dislikes
		Like.where(type_action: 1, class_name: "Line", object_id: self.id)
	end

	def update_line(params, current_user, car)

		return {status: 1} unless current_user.owner_of?(car)
		return {status: 1} unless GlobalOperations.time_format?(params["line"]["heure_depart"], params["line"]["heure_arrive"])
		return {status: 1} unless GlobalOperations.number?(params["line"]["prix"])
		return {status: 1} unless Ville.find_by(id: params["escale"]["depart_ville_id"])
		return {status: 1} unless Ville.find_by(id: params["escale"]["arrive_ville_id"])

		self.update(heure_depart: params["line"]["heure_depart"],
						   heure_arrive: params["line"]["heure_arrive"],
						   prix:params["line"]["prix"],
						   car_id: car.id)

		self.escales.delete_all

		Escale.create(line_id: self.id,
					  ville_id: params["escale"]["depart_ville_id"],
					  order_escale: 0)
		
		i_status = 1
		params["escale"]["escale_ville_id"].each do |escale_ville_id|
			next unless Ville.find_by(id: escale_ville_id)
			Escale.create(line_id: self.id,
					  	  ville_id: escale_ville_id,
					  	  order_escale: i_status)
			i_status += 1
		end if params["escale"]["escale_ville_id"]

		Escale.create(line_id: self.id,
					  ville_id: params["escale"]["arrive_ville_id"],
					  order_escale: i_status)
		
		{status: 0}
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
end