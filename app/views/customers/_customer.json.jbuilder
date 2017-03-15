json.extract! customer, :id, :id, :name, :long, :lat, :zone_name, :salesman_name, :status, :last_visited_at, :last_invoice_at, :last_trx_amount, :extra1, :extra2, :extra3, :created_at, :updated_at
json.url customer_url(customer, format: :json)
