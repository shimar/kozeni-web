require 'rails_helper'

RSpec.describe IncomesController, type: :controller do

  describe "GET #index" do
    describe "when a user signed in," do
      before do
        user_signed
      end

      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "when no user signed in," do
      it "redirects to welcome_path." do
        get :index
        expect(response).to redirect_to welcome_path
      end
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
