require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.new(name: "john doe", email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }

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
end
