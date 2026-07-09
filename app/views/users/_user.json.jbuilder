json.extract! user, :id, :username, :email, :password_digest, :first_name, :last_name, :bio, :role, :created_at, :updated_at
json.url user_url(user, format: :json)
