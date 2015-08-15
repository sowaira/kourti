class Escale < ActiveRecord::Base
	belongs_to :line
	belongs_to :ville
	# scope ordered: 
end
