class GlobalOperations
	def self.missing_params?(*params)
		params.each do |param|
			return false unless param.present?
		end if params
		true
	end

	def self.number?(value)
		!!(value.to_s =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/)
	end

	def self.email_valid?(value)
		!!(value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
	end

	def self.time_format?(*params)
		params.each do |param|
			return false unless param.present?
			vals = param.split(":")
			
			return false unless self.number?(vals[0]) and (0..23).include?(vals[0].to_i)
			return false unless self.number?(vals[1]) and (0..59).include?(vals[1].to_i)

		end if params
		true
	end
end