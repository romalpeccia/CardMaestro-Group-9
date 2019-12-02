require "rails_helper"
require_relative "../support/devise"

RSpec.describe CardsController, type: :controller do
  describe "Login in testing" do
    login_user
    context "from login user" do
      it "should return 200:OK" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "Without login" do
    context "without login" do
      it "should return 302 to redirect" do
        get :index
        expect(response).to have_http_status(:redirect)
      end
    end
  end

end
