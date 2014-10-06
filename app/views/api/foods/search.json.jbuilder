json.results do
	json.count @results.count
	json.page @page
	json.page_count @results.total_pages
end

json.foods @results do |food|
	json.extract! food, :id, :name
end
