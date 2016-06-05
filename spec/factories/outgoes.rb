FactoryGirl.define do
  factory :outgo do
    user_id     1
    category_id 1
    date        Date.today
    amount      0
    planned     false
  end
end
