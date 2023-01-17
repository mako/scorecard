class PullRequest < ApplicationRecord
  belongs_to :user

  enum state: [:open, :closed]

  scope :date_range, -> (range) { where(updated_at: range) }

end
