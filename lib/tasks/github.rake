namespace :github do

  desc "Fetch data from the Github repo"
  task fetch: :environment do
    response = HTTParty.get(
      "https://api.github.com/search/issues?q=repo:#{Rails.application.credentials.dig(:github, :repo)}+is:pr+created:%3E=#{(Date.today-30.week).strftime('%Y-%m-%d')}&per_page=30&sort=updated&order=desc",
      {
        format: :json,
        headers: {
          'User-Agent': 'request'
        }
      }
    )
    if response.code == 200 && response.parsed_response["total_count"] > 0
      response.parsed_response["items"].each do |pr_data|
        parse_pr(pr_data["pull_request"]["url"])
      end
    else
      puts "The #{Rails.application.credentials.dig(:github, :repo)} repo is not exists or no pull requests."
    end
  end

  def parse_pr(pr_url)
    response = HTTParty.get(
      pr_url,
      {
        format: :json,
        headers: {
          'User-Agent': 'request'
        }
      }
    )
    if response.code == 200
      pr_data = response.parsed_response
      user = get_user(pr_data["user"])
      pull_request = PullRequest.where(id: pr_data["id"], user: user).first_or_initialize
      if pull_request.new_record? || pull_request.state != pr_data["state"]
        pull_request.score = Rails.application.credentials.dig(:scores, :request) if pull_request.new_record?
        pull_request.created = DateTime.parse(pr_data["created_at"])
        pull_request.updated_at = DateTime.parse(pr_data["updated_at"])
        pull_request.state = pr_data["state"]
        pull_request.save
      end
      parse_comments(pull_request, pr_data["comments_url"]) if pr_data["comments"] > 0
      parse_reviews(pull_request, pr_data["review_comments_url"]) if pr_data["review_comments"] > 0
    else
      puts "Pull request not found: #{response.code}"
      exit
      false
    end
  end

  def parse_comments(pull_request, comments_url)
    response = HTTParty.get(
      comments_url,
      {
        format: :json,
        headers: {
          'User-Agent': 'request'
        }
      }
    )
    if response.code == 200
      response.parsed_response.each do |comment_data|
        user = get_user(comment_data["user"])
        comment = Comment.where(id: comment_data["id"], user: user, pull_request: pull_request).first_or_initialize
        if comment.new_record?
          comment.score = Rails.application.credentials.dig(:scores, :comment)
          comment.created = DateTime.parse(comment_data["created_at"])
          comment.save
        end
      end
    else
      false
    end
  end

  def parse_reviews(pull_request, reviews_url)
    response = HTTParty.get(
      reviews_url,
      {
        format: :json,
        headers: {
          'User-Agent': 'request'
        }
      }
    )
    if response.code == 200
      response.parsed_response.each do |review_data|
        user = get_user(review_data["user"])
        review = Review.where(id: review_data["id"], user: user, pull_request: pull_request).first_or_initialize
        if review.new_record?
          review.score = Rails.application.credentials.dig(:scores, :review)
          review.created = DateTime.parse(review_data["created_at"])
          review.save
        end
      end
    else
      false
    end
  end

  def get_user(user_data)
    user = User.where(id: user_data["id"]).first_or_initialize
    if user.new_record? || user.login_name != user_data["login"]
      user.login_name = user_data["login"]
      user.save
    end
    user
  end

end