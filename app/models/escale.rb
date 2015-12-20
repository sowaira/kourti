class Escale < ActiveRecord::Base
	belongs_to :line
	belongs_to :ville
	# scope ordered: 

	before_create :gererate_secure_random

	def gererate_secure_random
		self.token = SecureRandom.hex(10)
	end
end
