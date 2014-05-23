module NiceUrl
	extend ActiveSupport::Concern

	included do
		def to_param
			[id, name.parameterize].join('-')
		end
	end

	def find_by_param(input)
		find(input.to_i)
	end
end
