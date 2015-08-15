class Line < ActiveRecord::Base
	belongs_to :car
	has_many  :escales

	def self.create_line(params, current_user)
		line = Line.create(heure_depart: params["line"]["heure_depart"],
						   heure_arrive: params["line"]["heure_arrive"],
						   prix:params["line"]["prix"],
						   car_id: params["line"]["car_id"],
						   status: 0)

		Escale.create(line_id: line.id,
					  ville_id: params["escale"]["depart_ville_id"],
					  order_escale: 0)

		i_status = 1
		params["escale"]["escale_ville_id"].each do |escale_ville_id|
			Escale.create(line_id: line.id,
					  	  ville_id: escale_ville_id,
					  	  order_escale: i_status)
			i_status += 1
		end

		Escale.create(line_id: line.id,
					  ville_id: params["escale"]["arrive_ville_id"],
					  order_escale: i_status)

		
		line
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

	def update_line(params,current_user)
		self.update(heure_depart: params["line"]["heure_depart"],
						   heure_arrive: params["line"]["heure_arrive"],
						   prix:params["line"]["prix"],
						   car_id: params["line"]["car_id"])

		
		self.escales.delete_all

		Escale.create(line_id: self.id,
					  ville_id: params["escale"]["depart_ville_id"],
					  order_escale: 0)

		i_status = 1
		params["escale"]["escale_ville_id"].each do |escale_ville_id|
			Escale.create(line_id: self.id,
					  	  ville_id: escale_ville_id,
					  	  order_escale: i_status)
			i_status += 1
		end

		Escale.create(line_id: self.id,
					  ville_id: params["escale"]["arrive_ville_id"],
					  order_escale: i_status)

		
		
		
		
	end
end