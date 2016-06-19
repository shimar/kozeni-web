if @outgo.errors.empty?
  json.(@outgo,
        :id,
        :user_id,
        :category_id,
        :date,
        :amount,
        :planned,
        :created_at,
        :updated_at)
else
  json.errors @outgo.errors.full_messages
end
