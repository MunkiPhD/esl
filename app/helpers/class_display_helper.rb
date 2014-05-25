module ClassDisplayHelper
	def display_class_name(instance)
		"#{instance.class.name.underscore.humanize.titleize}"
	end
end
