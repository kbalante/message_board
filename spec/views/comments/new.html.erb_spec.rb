require 'rails_helper'

RSpec.describe "comments/new", type: :view do
  let(:user) { User.create!(name: "john doe", email: 'test@example.com', password: 'pAssword123#', password_confirmation: 'pAssword123#') }
  let(:posting) { Post.create!(title: "Ha Ling Peak", body: "Best trail in Canmore", user: user) }

  before(:each) do
    assign(:comment, Comment.new(
      post_id: posting.id,
      body: "MyText",
      user_id: user.id
    ))
  end

  it "renders new comment form" do
    render

    assert_select "form[action=?][method=?]", comments_path, "post" do

      assert_select "input[name=?]", "comment[post_id]"

      assert_select "textarea[name=?]", "comment[body]"

      assert_select "input[name=?]", "comment[user_id]"
    end
  end
end
