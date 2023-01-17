module Api
  module V1
    class PullRequestsController < ApplicationController

      def index
        render json: PullRequest.all.map{|pr|
          {
            id: pr.id,
            login_name: pr.user.login_name,
            state: pr.state,
            score: pr.score,
            created: pr.created
          }
        }
      end

      def show
        begin
          pr = PullRequest.find params[:id]
          render json: {
            id: pr.id,
            login_name: pr.user.login_name,
            state: pr.state,
            score: pr.score,
            created: pr.created
          }
        rescue ArgumentError => e
          render json: "Invalid data", status: 500
        rescue ActiveRecord::RecordNotFound
          render json: "Pull request not found", status: 404
        end
      end

    end
  end
end