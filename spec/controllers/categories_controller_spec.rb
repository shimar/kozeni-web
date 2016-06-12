require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe "GET #index" do
    context "when a user signed in," do
      before do
        user_signed
      end

      it "returns http success." do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context "when no user signed in," do
      it "redirects to welcome_path." do
        get :index
        expect(response).to redirect_to welcome_path
      end
    end
  end
end
