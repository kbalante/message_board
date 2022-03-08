require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  let(:user) { User.create!(name: "john doe", email: 'test@example.com', password: 'pAssword123#', password_confirmation: 'pAssword123#') }

  before(:each) do
    @post = assign(:post, Post.create!(
      title: "Title",
      body: "MyText",
      user_id: user.id
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
