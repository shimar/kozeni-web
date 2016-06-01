require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    describe "when user signed in," do
      before do
        user_signed
      end

      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "when user not signed in," do
      it "redirects to welcome_path." do
        get :index
        expect(response).to redirect_to welcome_path
      end
    end
  end

end
