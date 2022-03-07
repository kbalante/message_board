require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.new(name: "john doe", email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }
  let(:posting) { Post.new(title: "Ha Ling Peak", body: "Best trail in Canmore", user: user) }

  it "is valid with valid attributes" do
    comment = Comment.new(post: posting, body: "I agree with you 100%", user: user)
    expect(comment).to be_valid
  end

  it "is not valid without a body" do
    comment = Comment.new(post: posting, user: user)
    expect(comment).to_not be_valid
  end

  it "is not valid without a posting" do
    comment = Comment.new(body: "I agree with you 100%", user: user)
    expect(comment).to_not be_valid
  end

  it "is not valid without a user" do
    comment = Comment.new(post: posting, body: "I agree with you 100%")
    expect(comment).to_not be_valid
  end
end
