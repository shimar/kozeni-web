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
end
