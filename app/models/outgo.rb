class Outgo < ActiveRecord::Base
  # concerns.
  include InfluentialInBalance

  # associations.
  belongs_to :user
  belongs_to :category

  # validations.
  validates :user_id,
            presence: true
  validates :category_id,
            presence: true
  validates :amount,
            presence: true
  validates :date,
            presence: true

  # scopes.
  scope :ym, -> (date) {
    where("YEAR(date) = ? AND MONTH(date) = ?", date.year, date.month)
  }

  scope :sum_amount, -> {
    sum(:amount)
  }

  scope :amount_by_day, -> {
    group(:date).sum(:amount)
  }

  # callbacks.
  after_save :update_monthly_balance!
end
