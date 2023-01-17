RSpec.describe User, type: :model do
  it { should have_many(:pull_requests) }
  it { should have_many(:comments) }
  it { should have_many(:reviews) }
  it { should validate_presence_of(:login_name) }
 end