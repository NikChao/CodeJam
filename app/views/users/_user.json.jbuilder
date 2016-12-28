json.extract! user, :id, :name, :tag, :created_at, :updated_at
json.url user_url(user, format: :json)