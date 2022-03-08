require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create!(name: "john doe", email: 'test@example.com', password: 'pAssword123#', password_confirmation: 'pAssword123#') }
  let(:posting) { Post.create!(title: "Ha Ling Peak", body: "Best trail in Canmore", user: user) }

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

  it "orders by oldest first" do
    comment1 = Comment.create!(post: posting, body: "I agree with you 100%", user: user)
    comment2 = Comment.create!(post: posting, body: "I agree with you 200%", user: user)
    expect(Comment.by_oldest).to eq([comment1, comment2])
  end
end
