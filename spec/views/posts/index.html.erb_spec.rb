require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  let(:user) { User.create!(name: "john doe", email: 'test@example.com', password: 'pAssword123#', password_confirmation: 'pAssword123#') }

  before(:each) do
    assign(:posts, [
      Post.create!(
        title: "Title1",
        body: "MyText1",
        user_id: user.id
      ),
      Post.create!(
        title: "Title2",
        body: "MyText2",
        user_id: user.id
      )
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "tr>td", text: "Title1".to_s, count: 1
    assert_select "tr>td", text: "MyText2".to_s, count: 1
  end
end
