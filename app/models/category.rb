class Category < ActiveRecord::Base
  # associations.
  has_many   :incomes
  has_many   :outgos
  belongs_to :user
end
