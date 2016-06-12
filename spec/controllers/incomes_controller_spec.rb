require 'rails_helper'

RSpec.describe IncomesController, type: :controller do
  describe "POST #create" do
    context "when a user signed in," do
      before do
        user_signed
      end

      it "returns http success."
    end

    context "when no user signed in," do
      it "redirects to welcome_path."
    end
  end
end
