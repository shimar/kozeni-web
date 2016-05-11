class ItemForm
  include ActiveModel::Model

  attr_accessor :user_id
  attr_accessor :category_id
  attr_accessor :category
  attr_accessor :date
  attr_accessor :amount
  attr_accessor :planned

end
