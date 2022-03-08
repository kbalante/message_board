require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(name: "john doe", email: 'test@example.com', password: 'pAssword123#', password_confirmation: 'pAssword123#')
    expect(user).to be_valid
  end

  it "is not valid without a name" do
    user = User.new(email: 'test@example.com', password: 'pAssword123#', password_confirmation: 'pAssword123#')
    expect(user).to_not be_valid
  end

  it "is not valid without an email" do
    user = User.new(name: "john doe", password: 'pAssword123#', password_confirmation: 'pAssword123#')
    expect(user).to_not be_valid
  end

  it "is not valid without a password" do
    user = User.new(name: "john doe", email: 'test@example.com', password_confirmation: 'pAssword123#')
    expect(user).to_not be_valid
  end

  it "is not valid when password and confirmation do not match" do
    user = User.new(name: "john doe", email: 'test@example.com', password: 'pAssword123#', password_confirmation: 'pAssword123##')
    expect(user).to_not be_valid
  end

  it "is not valid when email format is incorrect" do
    user = User.new(name: "john doe", email: 'testexample.com', password: 'pAssword123#', password_confirmation: 'pAssword123#')
    expect(user).to_not be_valid
  end

  it "is not valid when password complexity is not met" do
    user = User.new(name: "john doe", email: 'test@example.com', password: '123', password_confirmation: '123')
    expect(user).to_not be_valid
    user = User.new(name: "john doe", email: 'test@example.com', password: 'password1', password_confirmation: 'password1')
    expect(user).to_not be_valid
    user = User.new(name: "john doe", email: 'test@example.com', password: 'pAssword1', password_confirmation: 'pAssword1')
    expect(user).to_not be_valid
  end
end
