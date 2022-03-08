require 'rails_helper'

RSpec.describe "posts/new", type: :view do
  let(:user) { User.create!(name: "john doe", email: 'test@example.com', password: 'pAssword123#', password_confirmation: 'pAssword123#') }

  before(:each) do
    assign(:post, Post.new(
      title: "MyString",
      body: "MyText",
      user_id: user.id
    ))
  end

  it "renders new post form" do
    render

    assert_select "form[action=?][method=?]", posts_path, "post" do

      assert_select "input[name=?]", "post[title]"

      assert_select "textarea[name=?]", "post[body]"

      assert_select "input[name=?]", "post[user_id]"
    end
  end
end
