class Income < ActiveRecord::Base
  # associations.
  belongs_to :user
  belongs_to :category

  # scopes.
  scope :ym, -> (date) {
    where("YEAR(date) = ? AND MONTH(date) = ?", date.year, date.month)
  }
end
