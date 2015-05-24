json.array!(@stores) do |store|
  json.extract! store, :id, :user_id, :name, :hidden
  json.url store_url(store, format: :json)
end
