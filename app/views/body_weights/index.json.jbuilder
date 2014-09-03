json.array! @body_weights do |body_weight|
	json.extract! body_weight, :id, :log_date, :weight, :unit_abbr
end
