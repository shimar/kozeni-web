if @income.errors.empty?
  json.(@income,
        :id,
        :user_id,
        :category_id,
        :date,
        :amount,
        :planned,
        :created_at,
        :updated_at)
else
  json.errors @income.errors.full_messages
end
