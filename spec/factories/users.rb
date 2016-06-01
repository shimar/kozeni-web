FactoryGirl.define do
  factory :user do
    email 'test@test.com'
    crypted_password '$2a$10$QjIzA3rwZn9A/U.f4d0wleMlGPbKVqRJSz3btRxJ5KKTxWWiwwfJy'
    salt 'WdCpLYj7uqpvB7zmJGyy'
  end
end
