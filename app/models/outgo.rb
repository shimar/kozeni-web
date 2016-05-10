class Outgo < ActiveRecord::Base
  # associations.
  belongs_to :user
  belongs_to :category
end
