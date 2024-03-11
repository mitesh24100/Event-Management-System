json.extract! ticket, :id, :confirmation_number, :number_of_tickets, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
