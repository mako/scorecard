require 'rails_helper'
RSpec.describe Api::V1::ScoresController do

  describe "GET /scores" do
    before do
      create :score_container, :with_scores
      get :index
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "JSON body response contains expected score attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.first.keys).to match_array(["year","week","total_score", "scores"])
    end
  end

  describe "GET /scores/:year/:week" do
    before do
      params = {year: 2023, week: 2, format: :json}
      create :score
      get :week, params: params
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "JSON body response contains expected user attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(["year","week","total_score", "scores"])
    end
  end
end