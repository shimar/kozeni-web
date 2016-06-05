require 'rails_helper'

RSpec.describe Income, type: :model do
  describe "associations." do
    before do
      @model = Income.new
    end

    it "belongs to a user." do
      expect(@model.respond_to?(:user)).to be_truthy
    end

    it "belongs to a category." do
      expect(@model.respond_to?(:category)).to be_truthy
    end
  end

  describe "scopes" do
    describe "ym" do
      before do
        create(:income)
        create(:income, date: Date.today - 1.months)
      end

      it "finds the records which have same year and month to given year and month." do
        expect(Income.ym(Date.today).count).to eq 1
      end
    end

    describe "sum_amount" do
      before do
        create(:income, amount: 100)
        create(:income, amount: 200)
      end

      it "calculates the summary of amounts." do
        expect(Income.sum_amount).to eq 300
      end
    end

    describe "amount_by_day" do
      before do
        create(:income, date: Date.today - 1.days, amount: 100)
        create(:income, date: Date.today - 1.days, amount: 200)
        create(:income, date: Date.today, amount: 300)
        create(:income, date: Date.today, amount: 400)
      end

      it "" do
        res = Income.amount_by_day
        expect(res.size).to eq 2
        expect(res.key?(Date.today - 1.days)).to be_truthy
        expect(res[Date.today - 1.days]).to eq 300
        expect(res.key?(Date.today)).to be_truthy
        expect(res[Date.today]).to eq 700
      end
    end
  end

  describe "as InfluentialInMonthlyBalance" do
    describe "find_or_initialize_monthly_balance" do
      before do
        @model = build(:income)
      end

      context "when the monthly balance exists," do
        before do
          today = Date.today
          @exists = create(:balance,
                           type: 'MonthlyBalance',
                           date: today.beginning_of_month,
                           income: 10000,
                           outgo: 2000)
        end

        it "returns the monthly balance." do
          mb = @model.find_or_initialize_monthly_balance
          expect(mb.id).to eq @exists.id
        end
      end

      context "when the monthly balance not exists," do
        it "returns new instance of monthly balance." do
          mb = @model.find_or_initialize_monthly_balance
          expect(mb).to be_instance_of MonthlyBalance
          expect(mb.persisted?).to be_falsy
          expect(mb.user_id).to eq @model.user_id
          expect(mb.date.year).to eq @model.date.year
          expect(mb.date.month).to eq @model.date.month
          expect(mb.date.day).to eq 1
          expect(mb.income).to eq 0
          expect(mb.outgo).to eq 0
        end
      end
    end
  end
end
