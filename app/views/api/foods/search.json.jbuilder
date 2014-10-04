json.array! @results do |food|
	json.extract! food, :id, :name
end
