require 'rails_helper'

RSpec.describe Category, type: :model do

  describe "validations" do
    before do
      @model = Category.new
    end

    describe "user_id" do
      it "should be presence." do
        @model.valid?
        expect(@model.errors.key?(:user_id)).to be_truthy
        @model.user_id = 1
        @model.valid?
        expect(@model.errors.key?(:user_id)).to be_falsy
      end
    end

    describe "name" do
      it "should be presence." do
        @model.valid?
        expect(@model.errors.key?(:name)).to be_truthy
        @model.name = 'category1'
        @model.valid?
        expect(@model.errors.key?(:name)).to be_falsy
      end

      it "should be unique." do
        @category1 = create(:category)
        @model.user_id = @category1.user_id
        @model.name = @category1.name
        @model.valid?
        expect(@model.errors.key?(:name)).to be_truthy
        @model.user_id = 2
        @model.valid?
        expect(@model.errors.key?(:name)).to be_falsy
      end

      it "should be 80 characters or less." do
        name = ""
        80.times { name << "0" }
        @model.name = name
        @model.valid?
        expect(@model.errors.key?(:name)).to be_falsy
        @model.name << "0"
        @model.valid?
        expect(@model.errors.key?(:name)).to be_truthy
      end
    end
  end
end
