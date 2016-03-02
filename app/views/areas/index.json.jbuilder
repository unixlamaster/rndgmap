json.array!(@areas) do |area|
  json.extract! area, :id, :coords, :name, :zoom
  json.url area_url(area, format: :json)
end
