require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /about_us" do
    it "returns http success" do
      get "/static_pages/about_us"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /contact_us" do
    it "returns http success" do
      get "/static_pages/contact_us"
      expect(response).to have_http_status(:success)
    end
  end

end
