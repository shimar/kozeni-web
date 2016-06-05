module InfluentialInBalance
  extend ActiveSupport::Concern

  included do

    def find_or_initialize_monthly_balance
      mb = MonthlyBalance.where(user_id: self.user_id)
           .where("YEAR(date) = ? AND MONTH(date) = ?", self.date.year, self.date.month)
           .first
      unless mb
        mb = MonthlyBalance.new(user_id: self.user_id,
                                date: Date.new(self.date.year, self.date.month, 1),
                                income: 0,
                                outgo: 0)
      end
      mb
    end

    def update_monthly_balance!
      mb = find_or_initialize_monthly_balance
      user = self.user
      mb.income = user.incomes.ym(self.date).sum_amount
      mb.outgo  = user.outgoes.ym(self.date).sum_amount
      mb.save!
    end
  end

end
