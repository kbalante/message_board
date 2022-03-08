require 'rails_helper'

RSpec.describe "comments/edit", type: :view do
  let(:user) { User.create!(name: "john doe", email: 'test@example.com', password: 'pAssword123#', password_confirmation: 'pAssword123#') }
  let(:posting) { Post.create!(title: "Ha Ling Peak", body: "Best trail in Canmore", user: user) }

  before(:each) do
    @comment = assign(:comment, Comment.create!(
      post_id: posting.id,
      body: "MyText",
      user_id: user.id
    ))
  end

  it "renders the edit comment form" do
    render

    assert_select "form[action=?][method=?]", comment_path(@comment), "post" do

      assert_select "input[name=?]", "comment[post_id]"

      assert_select "textarea[name=?]", "comment[body]"

      assert_select "input[name=?]", "comment[user_id]"
    end
  end
end
