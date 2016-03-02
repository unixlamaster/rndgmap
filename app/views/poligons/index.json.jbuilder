json.array!(@poligons) do |poligon|
  json.extract! poligon, :id, :coords, :name, :url, :year
  json.url poligon_url(poligon, format: :json)
end
