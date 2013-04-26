json.array!(@pending_members) do |member|
  json.extract! member, :id, :username
  json.approve_url approve_circle_member_url(@circle, member)
end
