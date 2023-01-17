require 'rails_helper'
RSpec.describe Api::V1::PullRequestsController do

  describe "GET /pull-requests" do
    before do
      create_list :pull_request, 3
      get :index
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "JSON body response contains expected pull request attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.first.keys).to match_array(["id", "login_name", "state", "score", "created"])
    end
  end

  describe "GET /pull-requests/:id" do
    before do
      pr = create :pull_request
      params = {id: pr.id, format: :json}
      get :show, params: params
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "JSON body response contains expected user attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(["id", "login_name", "state", "score", "created"])
    end
  end
end