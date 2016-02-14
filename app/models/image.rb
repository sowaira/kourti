class Image < ActiveRecord::Base

	def self.url_of(class_name, object, image_type)
		return DEFAULT_IMAGE unless object
		image = Image.find_by(class_name: class_name, object_id: object.id, image_type:image_type)
		return image.link if image
		DEFAULT_IMAGE 
	end

end
