require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.new(name: "john doe", email: 'test@example.com', password: 'pAssword123#', password_confirmation: 'pAssword123#') }

  it "is valid with valid attributes" do
    post = Post.new(title: "Ha Ling Peak", body: "Best trail in Canmore", user: user)
    expect(post).to be_valid
  end

  it "is not valid without a title" do
    post = Post.new(title: nil, body: "test body", user: user)
    expect(post).to_not be_valid
  end

  it "is not valid without a user" do
    post = Post.new(title: "East End of Rundle", body: "The scariest trail to do in the winter")
    expect(post).to_not be_valid
  end

  it "is valid without a description" do
    post = Post.new(title: "Hello There", user: user)
    expect(post).to be_valid
  end

  it "orders by most recent first" do
    post1 = Post.create!(title: "first", user: user)
    post2 = Post.create!(title: "second", user: user)
    expect(Post.by_most_recent).to eq([post2, post1])
  end
end
