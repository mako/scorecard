module Api
  module V1
    class ScoresController < ApplicationController

      def index
        data = []
        (0..30).each do |i|
          date = Date.today - i.week
          week_data = get_week_data(date.strftime('%Y').to_i, date.strftime('%V'))
          data << week_data if week_data[:total_score] > 0
        end
        render json: data
      end

      def week
        year = params[:year].to_i
        week = params[:week].to_i
        begin
          render json: get_week_data(year, week)
        rescue ArgumentError => e
          render json: "Invalid week", status: 500
        end
      end

      private

      def get_week_data(year, week)
        date_range = Date.commercial(year.to_i, week.to_i, 1)..Date.commercial(year.to_i, week.to_i, 7)
        total_score = 0
        weekly_data = {}
        PullRequest.date_range(date_range).each do |pr|
          weekly_data[pr.user.login_name] = 0 unless weekly_data[pr.user.login_name].present?
          weekly_data[pr.user.login_name] += pr.score
          total_score += pr.score
        end
        Comment.date_range(date_range).each do |c|
          weekly_data[c.user.login_name] = 0 unless weekly_data[c.user.login_name].present?
          weekly_data[c.user.login_name] += c.score
          total_score += c.score
        end
        Review.date_range(date_range).each do |r|
          weekly_data[r.user.login_name] = 0 unless weekly_data[r.user.login_name].present?
          weekly_data[r.user.login_name] += r.score
          total_score += r.score
        end
        data = {year: year, week: week, total_score: total_score, scores: weekly_data}
      end

    end
  end
end