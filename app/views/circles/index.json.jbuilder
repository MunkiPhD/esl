json.array!(@circles) do |circle|
  json.extract! circle, :name, :motto, :description, :is_public
  json.url circle_url(circle, format: :json)
end