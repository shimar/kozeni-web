class Category < ActiveRecord::Base
  # associations.
  has_many   :incomes
  has_many   :outgos
  belongs_to :user

  # validations
  validates :user_id,
            presence: true

  validates :name,
            presence: true,
            uniqueness: {
              allow_blank: true,
              scope: :user_id
            },
            length: {
              maximum: 80,
              allow_blank: true
            }
end
