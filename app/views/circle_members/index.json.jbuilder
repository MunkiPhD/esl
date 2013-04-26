json.array!(@members) do |member|
  json.extract! member, :id, :username
end
