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

  describe "validations" do
    before do
      @model = Income.new
    end

    describe "user_id" do
      it "is required." do
        @model.valid?
        expect(@model.errors.key?(:user_id)).to be_truthy
        @model.user_id = 1
        @model.valid?
        expect(@model.errors.key?(:user_id)).to be_falsy
      end
    end

    describe "category_id" do
      it "is required." do
        @model.valid?
        expect(@model.errors.key?(:category_id)).to be_truthy
        @model.category_id = 1
        @model.valid?
        expect(@model.errors.key?(:category_id)).to be_falsy
      end
    end

    describe "amount" do
      it "is required." do
        @model.valid?
        expect(@model.errors.key?(:amount)).to be_truthy
        @model.amount = 0
        @model.valid?
        expect(@model.errors.key?(:amount)).to be_falsy
      end
    end

    describe "date" do
      it "is required." do
        @model.valid?
        expect(@model.errors.key?(:date)).to be_truthy
        @model.date = Date.today
        @model.valid?
        expect(@model.errors.key?(:date)).to be_falsy
      end
    end
  end


  describe "scopes" do
    describe "ym" do
      before do
        create(:user, id: 1, password: 'testtest', password_confirmation: 'testtest')
        create(:income)
        create(:income, date: Date.today - 1.months)
      end

      it "finds the records which have same year and month to given year and month." do
        expect(Income.ym(Date.today).count).to eq 1
      end
    end

    describe "sum_amount" do
      before do
        create(:user, id: 1, password: 'testtest', password_confirmation: 'testtest')
        create(:income, amount: 100)
        create(:income, amount: 200)
      end

      it "calculates the summary of amounts." do
        expect(Income.sum_amount).to eq 300
      end
    end

    describe "amount_by_day" do
      before do
        create(:user, id: 1, password: 'testtest', password_confirmation: 'testtest')
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

    describe "update_monthly_balance!" do
      before do
        @user  = create(:user, password: 'testtest', password_confirmation: 'testtest')
        @model = build(:income, user_id: @user.id, amount: 100, category_id: 1)
      end

      it "saves the monthly balance record." do
        expect {
          @model.update_monthly_balance!
        }.to change {
          MonthlyBalance.count
        }.from(0).to(1)
      end

      describe do
        before do
          create(:income, user_id: @user.id, amount: 1, date: Date.today)
        end

        it "calculates the summary of incomes." do
          @model.update_monthly_balance!
          mb = @model.find_or_initialize_monthly_balance
          expect(mb.income).to eq 1
        end
      end

      describe do
        before do
          create(:outgo, user_id: @user.id, amount: -1, date: Date.today)
        end

        it "calculates the summary of outgoes." do
          @model.update_monthly_balance!
          mb = @model.find_or_initialize_monthly_balance
          expect(mb.outgo).to eq -1
        end
      end
    end
  end
end
