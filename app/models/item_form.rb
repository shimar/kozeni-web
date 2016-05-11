class ItemForm
  include ActiveModel::Model

  attr_accessor :user_id
  attr_accessor :category_id
  attr_accessor :date
  attr_accessor :integer
  attr_accessor :planned

end
