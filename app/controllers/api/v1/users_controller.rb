module Api
  module V1
    class UsersController < ApplicationController

      def index
        render json: User.all.map{|u| {id: u.id, login_name: u.login_name}}
      end

      def show
        begin
          user = User.find_by_login_name params[:login_name]
          score = 0
          if user
            if params[:year].present? && params[:week].present?
              date_range = Date.commercial(params[:year].to_i,params[:week].to_i,1)..Date.commercial(params[:year].to_i,params[:week].to_i,7)
              pull_requests = user.pull_requests.date_range(date_range)
              comments = user.comments.date_range(date_range)
              reviews = user.reviews.date_range(date_range)
            else
              pull_requests = user.pull_requests
              comments = user.comments
              reviews = user.reviews
            end
            pull_requests.map{|pr| score += pr.score}
            comments.map{|c| score += c.score}
            reviews.map{|r| score += r.score}
            data = {
              id: user.id,
              login_name: user.login_name,
              score: score,
              pull_requests: pull_requests.map{|pr| {id: pr.id, state: pr.state, score: pr.score, created: pr.created}},
              comments: comments.map{|c| {id: c.id, pull_request: c.pull_request_id, score: c.score, created: c.created}},
              reviews: reviews.map{|r| {id: r.id, pull_request: r.pull_request_id, score: r.score, created: r.created}}
            }
            render json: data
          else
            render json: "User not found", status: 404
          end
        rescue ArgumentError => e
          render json: "Invalid date", status: 500
        end
      end

    end
  end
end