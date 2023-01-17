class Review < ApplicationRecord
  belongs_to :user
  belongs_to :pull_request

  scope :date_range, -> (range) { where(updated_at: range) }

end
