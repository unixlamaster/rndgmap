json.array!(@mapobjs) do |mapobj|
  json.extract! mapobj, :id, :year, :class, :latitude, :longtitude, :url, :name, :address
  json.url mapobj_url(mapobj, format: :json)
end
