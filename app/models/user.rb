class User < ApplicationRecord
  has_many :pull_requests
  has_many :comments
  has_many :reviews

  validates :login_name, presence: true
end
