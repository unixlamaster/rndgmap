json.array!(@type_objs) do |type_obj|
  json.extract! type_obj, :id, :objclass, :src
  json.url type_obj_url(type_obj, format: :json)
end
