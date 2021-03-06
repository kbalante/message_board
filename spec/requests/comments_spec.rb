require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/comments", type: :request do
  let(:user) { User.create!(name: "john doe", email: 'test@example.com', password: 'pAssword123#', password_confirmation: 'pAssword123#') }
  let(:posting) { Post.create!(title: "Ha Ling Peak", body: "Best trail in Canmore", user: user) }

  # This should return the minimal set of attributes required to create a valid
  # Comment. As you add validations to Comment, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { body: "I agree with you", user_id:  user.id, post_id: posting.id }
  }

  let(:invalid_attributes) {
    { user_id:  user.id }
  }

  describe "GET /new" do
    it "renders an unsuccessful response if user is not logged in" do
      get new_comment_url
      expect(response).to_not be_successful
    end

    it "renders a successful response if user is logged in" do
      sign_in(user)
      get new_comment_url({ post_id: posting.id })
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders an unsuccessful response if the user is not logged in" do
      comment = Comment.create! valid_attributes
      get edit_comment_url(comment)
      expect(response).to_not be_successful
    end

    it "renders a successful response" do
      sign_in(user)
      comment = Comment.create! valid_attributes
      get edit_comment_url(comment)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "does not create a new Comment if not signed in" do
        expect {
          post comments_url, params: { comment: valid_attributes }
        }.to change(Comment, :count).by(0)
      end

      it "creates a new Comment" do
        sign_in(user)
        expect {
          post comments_url, params: { comment: valid_attributes }
        }.to change(Comment, :count).by(1)
      end

      it "redirects to the created comment" do
        sign_in(user)
        post comments_url, params: { comment: valid_attributes }
        expect(response).to redirect_to(post_url(posting))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Comment" do
        sign_in(user)
        expect {
          post comments_url, params: { comment: invalid_attributes }
        }.to change(Comment, :count).by(0)
      end

      it "renders an unsuccessful response with invalid attributes" do
        sign_in(user)
        post comments_url, params: { comment: invalid_attributes }
        expect(response).to_not be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { body: "That last comment was fire", user_id:  user.id, post_id: posting.id }
      }

      it "does not update the requested comment if not logged in" do
        comment = Comment.create! valid_attributes
        patch comment_url(comment), params: { comment: new_attributes }
        comment.reload
        expect(comment.body).to_not eq("That last comment was fire")
      end

      it "updates the requested comment" do
        sign_in(user)
        comment = Comment.create! valid_attributes
        patch comment_url(comment), params: { comment: new_attributes }
        comment.reload
        expect(comment.body).to eq("That last comment was fire")
      end

      it "redirects to the comment" do
        sign_in(user)
        comment = Comment.create! valid_attributes
        patch comment_url(comment), params: { comment: new_attributes }
        comment.reload
        expect(response).to redirect_to(post_url(comment.post))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        sign_in(user)
        comment = Comment.create! valid_attributes
        patch comment_url(comment), params: { comment: invalid_attributes }
        expect(response).to_not be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "does not destroy the requested comment if not signed in" do
      comment = Comment.create! valid_attributes
      expect {
        delete comment_url(comment)
      }.to change(Comment, :count).by(0)
    end

    it "destroys the requested comment" do
      sign_in(user)
      comment = Comment.create! valid_attributes
      expect {
        delete comment_url(comment)
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to the comments list" do
      sign_in(user)
      comment = Comment.create! valid_attributes
      delete comment_url(comment)
      expect(response).to redirect_to(post_url(comment.post))
    end
  end
end
