json.extract! admin, :id, :email, :password, :name, :phone_number, :address, :credit_card_number, :created_at, :updated_at
json.url admin_url(admin, format: :json)
