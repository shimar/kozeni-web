require 'rails_helper'

RSpec.describe Outgo, type: :model do
  describe "associations" do
    before do
      @model = Outgo.new
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
      @model = Outgo.new
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
        create(:outgo)
        create(:outgo, date: Date.today - 1.months)
      end

      it "finds the records which have same year and month to given year and month." do
        expect(Outgo.ym(Date.today).count).to eq 1
      end
    end

    describe "sum_amount" do
      before do
        create(:user, id: 1, password: 'testtest', password_confirmation: 'testtest')
        create(:outgo, amount: 100)
        create(:outgo, amount: 200)
      end

      it "calculates the summary of amounts." do
        expect(Outgo.sum_amount).to eq 300
      end
    end

    describe "amount_by_day" do
      before do
        create(:user, id: 1, password: 'testtest', password_confirmation: 'testtest')
        create(:outgo, date: Date.today - 1.days, amount: 100)
        create(:outgo, date: Date.today - 1.days, amount: 200)
        create(:outgo, date: Date.today, amount: 300)
        create(:outgo, date: Date.today, amount: 400)
      end

      it do
        res = Outgo.amount_by_day
        expect(res.size).to eq 2
        expect(res.key?(Date.today - 1.days)).to be_truthy
        expect(res[Date.today - 1.days]).to eq 300
        expect(res.key?(Date.today)).to be_truthy
        expect(res[Date.today]).to eq 700
      end
    end
  end
end
