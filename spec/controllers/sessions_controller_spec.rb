require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "returns http success" do
      post :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    it "returns 302 if user not loggedin." do
      delete :destroy
      expect(response.status).to eq 302
    end

    describe "when user loggedin," do
      before do
        @user = User.new(email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest')
        @user.save
        @controller.login(@user.email, 'testtest')
      end

      it "returns 302 and redirect_to welcome_path." do
        delete :destroy
        expect(response.status).to eq 302
        expect(response).to redirect_to welcome_path
      end
    end
  end

end
