json.extract! review, :id, :feedback, :rating, :created_at, :updated_at
json.url review_url(review, format: :json)
